#!/bin/bash
# A script to backup GitLab repositories.

GLAB_BACKUP_DIR=${GLAB_BACKUP_DIR-"gitlab_backup"}                   # where to place the backup files
GLAB_TOKEN=${GLAB_TOKEN-"YOUR_TOKEN"}                                # the access token of the account
GLAB_GITHOST=${GLAB_GITHOST-"gitlab.com"}                            # the GitLab hostname
GLAB_PRUNE_OLD=${GLAB_PRUNE_OLD-true}                                # when `true`, old backups will be deleted
GLAB_PRUNE_AFTER_N_DAYS=${GLAB_PRUNE_AFTER_N_DAYS-7}                 # the min age (in days) of backup files to delete
GLAB_SILENT=${GLAB_SILENT-false}                                     # when `true`, only show error messages
GLAB_API=${GLAB_API-"https://gitlab.com/api/v3"}                     # base URI for the GitLab API
GLAB_GIT_CLONE_CMD="git clone --quiet --mirror git@${GLAB_GITHOST}:" # base command to use to clone GitLab repos

TSTAMP=`date "+%Y%m%d"`

# The function `check` will exit the script if the given command fails.
function check {
  "$@"
  status=$?
  if [ $status -ne 0 ]; then
    echo "ERROR: Encountered error (${status}) while running the following:" >&2
    echo "           $@"  >&2
    echo "       (at line ${BASH_LINENO[0]} of file $0.)"  >&2
    echo "       Aborting." >&2
    exit $status
  fi
}

# The function `tgz` will create a gzipped tar archive of the specified file ($1) and then remove the original
function tgz {
   check tar zcf $1.tar.gz $1 && check rm -rf $1
}

$GLAB_SILENT || (echo "" && echo "=== INITIALIZING ===" && echo "")

$GLAB_SILENT || echo "Using backup directory $GLAB_BACKUP_DIR"
check mkdir -p $GLAB_BACKUP_DIR

$GLAB_SILENT || echo -n "Fetching list of repositories ..."
GLAB_PROJ_API="${GLAB_API}/projects?private_token=${GLAB_TOKEN}&per_page=100&simple=true"
echo ${GLAB_PROJ_API}

REPOLIST=`check curl --silent ${GLAB_PROJ_API} | check perl -p -e "s/,/\n/g" | check grep "\"path_with_namespace\"" | check awk -F':"' '{print $2}' | check sed -e 's/"}//g'`

$GLAB_SILENT || echo "found `echo $REPOLIST | wc -w` repositories."

$GLAB_SILENT || (echo "" && echo "=== BACKING UP ===" && echo "")

for REPO in $REPOLIST; do
   $GLAB_SILENT || echo "Backing up ${REPO}"
   check ${GLAB_GIT_CLONE_CMD}${REPO}.git ${GLAB_BACKUP_DIR}/${GLAB_ORG}-${REPO}-${TSTAMP}.git && tgz ${GLAB_BACKUP_DIR}/${GLAB_ORG}-${REPO}-${TSTAMP}.git
done

if $GLAB_PRUNE_OLD; then
  $GLAB_SILENT || (echo "" && echo "=== PRUNING ===" && echo "")
  $GLAB_SILENT || echo "Pruning backup files ${GLAB_PRUNE_AFTER_N_DAYS} days old or older."
  $GLAB_SILENT || echo "Found `find $GLAB_BACKUP_DIR -name '*.tar.gz' -mtime +$GLAB_PRUNE_AFTER_N_DAYS | wc -l` files to prune."
  find $GLAB_BACKUP_DIR -name '*.tar.gz' -mtime +$GLAB_PRUNE_AFTER_N_DAYS -exec rm -fv {} > /dev/null \;
fi

$GLAB_SILENT || (echo "" && echo "=== DONE ===" && echo "")
$GLAB_SILENT || (echo "GitLab backup completed." && echo "")