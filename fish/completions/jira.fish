set -l jira_commands "help version acknowledge assign backlog block browse close comment components create createmeta done dup edit editmeta export-templates fields in-progress issuelink issuelinktypes issuetypes list login logout ls lsme rank reopen request resolve start stop subtask take todo transition transitions transmeta unassign unexport-templates view vote watch session"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a $jira_commands

# per command completion
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a help -d "Show help."
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a version -d "Prints version"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a acknowledge -d "Transition issue to acknowledge state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a assign -d "Assign user to issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a backlog -d "Transition issue to Backlog state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a block -d "Mark issues as blocker"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a browse -d "Open issue in browser"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a close -d "Transition issue to close state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a comment -d "Add comment to issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a components -d "Show components for a project"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a create -d "Create issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a createmeta -d "View 'create' metadata"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a done -d "Transition issue to Done state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a dup -d "Mark issues as duplicate"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a edit -d "Edit issue details"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a editmeta -d "View 'edit' metadata"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a export-templates -d "Export templates for customizations"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a fields -d "Prints all fields, both System and Custom"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a in-progress -d "Transition issue to Progress state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a issuelink -d "Link two issues"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a issuelinktypes -d "Show the issue link types"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a issuetypes -d "Show issue types for a project"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a list -d "Prints list of issues for given search criteria"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a ls -d "Prints list of issues for given search criteria"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a lsme -d "Prints list of issues attached to me"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a login -d "Attempt to login into jira server"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a logout -d "Deactivate session with Jira server"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a rank -d "Mark issues as blocker"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a reopen -d "Transition issue to reopen state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a request -d "Open issue in requestr"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a resolve -d "Transition issue to resolve state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a start -d "Transition issue to start state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a stop -d "Transition issue to stop state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a subtask -d "Subtask issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a take -d "Assign issue to yourself"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a todo -d "Transition issue to To Do state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a transition -d "Transition issue to given state"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a transitions -d "List valid issue transitions"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a transmeta -d "List valid issue transitions"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a unassign -d "Unassign an issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a unexport-templates -d "Remove unmodified exported templates"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a view -d "Prints issue details"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a vote -d "Vote up/down an issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a watch -d "Add/Remove watcher to issue"
complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a session -d "Attempt to login into jira server"

# these cause issues atm
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a attach create -d "Attach file to issue"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a attach get -d "Fetch attachment"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a attach list -d "Prints attachment details for issue"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a attach remove -d "Delete attachment"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a component add -d "Add component"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a epic add -d "Add issues to Epic"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a epic create -d "Create Epic"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a epic list -d "Prints list of issues for an epic with optional search criteria"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a epic remove -d "Remove issues from Epic"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a labels add -d "Add labels to an issue"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a labels remove -d "Remove labels from an issue"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a labels set -d "Set labels on an issue"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a worklog add -d "Add a worklog to an issue"
# complete -f -c jira -n "not __fish_seen_subcommand_from $jira_commands" -a worklog list -d "Prints the worklog data for given issue"
