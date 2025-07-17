#!/usr/bin/env python3

from github.PullRequest import PullRequest
from github.Repository import Repository
from github import Github
from github import Auth
import concurrent.futures
import subprocess

USER = "elliott"

def get_repo():
    token = subprocess.check_output(["gh", "auth", "token"], text=True).strip()
    auth = Auth.Token(token)

    g = Github(auth=auth)
    g.get_user().login

    repo_str = subprocess.check_output(
        ["gh", "repo", "view", "--json", "owner,name", "--jq", ".owner.login,.name"],
        text=True
    ).strip()
    repo_str = "/".join(repo_str.split("\n"))
    org = repo_str.split("/")[0]
    return (g.get_repo(repo_str), org)

def get_children_branches(change_id: str):
    CHILDREN_CMD = f"""
    jj log -r "(fork_point(local_trunk()::{change_id})::{change_id} | {change_id}::latest(heads({change_id}:: & bookmarks(glob:'{USER}/*')))) & bookmarks(glob:'{USER}/*')" --no-pager --color=never --no-graph -T "remote_bookmarks.filter(|b| b.name().starts_with('{USER}/') && b.remote() == 'git').map(|b| b.name()) ++ \\"\\n\\""
    """
    return subprocess.check_output(CHILDREN_CMD, shell=True, text=True).strip().splitlines()

def get_children_prs(repo: Repository, org: str,branches: list[str]):
    with concurrent.futures.ThreadPoolExecutor() as executor:
        prs_lists = list(executor.map(lambda branch: list(repo.get_pulls(state='all', head=f"{org}:{branch}")), branches))
    return [prs[0] for prs in prs_lists]

def write_comment_for_pr(all_prs: list[PullRequest], pr: PullRequest):
    body = "\n".join([
        f"- #{i.number} {' 👈' if i.number == pr.number else ''}"
        for i in children_prs
    ])
    comment = f"""
### 🥞 Pull Request Stack
{body}
<!-- this_is_the_jj_pr_stack_comment -->
    """
    upsert_stack_comment(pr, comment)

def upsert_stack_comment(pr: PullRequest, body: str):
    """
    Find or create the stack comment on the PR, updating if it exists.
    """
    # Find existing comment
    comments = list(pr.get_issue_comments())
    stack_comment = next((c for c in comments if "this_is_the_jj_pr_stack_comment" in c.body), None)
    if stack_comment:
        stack_comment.edit(body)
    else:
        pr.create_issue_comment(body)

if __name__ == "__main__":
    import sys
    change_id = sys.argv[1]
    assert change_id, "change_id is required"
    print(f"Writing PR stack comment for \"{change_id}\" and its children")

    repo, org = get_repo()
    branches = get_children_branches(change_id)
    children_prs = get_children_prs(repo, org, branches)

    with concurrent.futures.ThreadPoolExecutor() as executor:
        list(executor.map(lambda pr: write_comment_for_pr(children_prs, pr), children_prs))
