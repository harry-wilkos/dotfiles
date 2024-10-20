#
# AUTO GENERATED BY 'fish-lsp'
#
#   * Any command should generate the completions file
#
#      >_ fish-lsp complete > ~/.config/fish/completions/fish-lsp.fish
#      >_ fish-lsp complete --fish > ~/.config/fish/completions/fish-lsp.fish
#      >_ yarn install # from inside the 'fish-lsp' 
#
#   * You can test the completions by editing:
#
#         ~/.config/fish/completions/fish-lsp.fish 
#
#     or by using the command:
#
#      >_ fish-lsp complete
#
#     to visually check what is wrong
#
#   * For more info, try editing the generated output inside:
#
#         ~/...install_path.../fish-lsp/src/utils/get-lsp-completions.ts 
#


# Returns exit code of 0 if any command (argv[1..-1]) appears once, ignores flags.
function __fish_lsp_using_command
    set -l commands $argv
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1
        set -l command_seen_once 1
        for c in $cmd[2..-1]
            switch $c
                case '-*'
                    continue
                case $commands
                    # If the command is seen more than once then return 1
                    if test $command_seen_once -eq 1
                        set command_seen_once 0
                    else
                        return 1
                    end
                case '*'
                    if test $command_seen_once -eq 0
                        return 0
                    else
                        return 1
                    end
            end
        end
        return $command_seen_once
    end
    return 1
end

# disable file completions
complete -c fish-lsp -f

complete -c fish-lsp -n "__fish_use_subcommand" -a "
start\t'subcmd to start the lsp using stdin/stdout'
logger\t'test the logger by displaying it'
info\t'show the build info of fish-lsp'
url\t'show a helpful url related to the fish-lsp'
complete\t'generate completions file for ~/.config/fish/completions'
env\t'generate fish shell env variables to be used by lsp'"

set __fish_lsp_subcommands start

# fish_lsp [start] --<TAB> 
complete -c fish-lsp -n '__fish_seen_subcommand_from $__fish_lsp_subcommands' -a "
--dump\t'dump output and stop server'
--enable\t'enable feature'
--disable\t'disable feature'"

# fish-lsp url --<TAB>
complete -c fish-lsp -n "__fish_seen_subcommand_from url" -a "
--repo	'show git url'
--git	'show git url'
--npm	'show npm url'
--homepage	'show homepage url'
--contributions	'show git contributions url'
--wiki	'show git wiki url'
--issues	'show git issues url'
--report	'show git issues url'
--discussions	'show git discussions url'
--clients-repo	'show git clients-repo url'
--sources	'show useful list of sources'"

# fish-lsp complete <TAB>
complete -c fish-lsp -n __fish_use_subcommand -a complete -d 'completion utils for fish-lsp cli'
complete -c fish-lsp -n '__fish_lsp_using_command complete; and not __fish_contains_opt features' -l features -d 'show features'
complete -c fish-lsp -n '__fish_lsp_using_command complete; and not __fish_contains_opt fish'     -l fish     -d 'show completion/fish-lsp.fish'
complete -c fish-lsp -n '__fish_lsp_using_command complete; and not __fish_contains_opt names'    -l names    -d 'show feature names of completions'
complete -c fish-lsp -n '__fish_lsp_using_command complete; and not __fish_contains_opt toggle'   -l toggle   -d 'show feature names of completions'

# fish-lsp info --<TAB>
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt bin'           -l bin            -d 'show the binary path'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt repo'          -l repo           -d 'show the repo path'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt time'          -l time           -d 'show the build-time'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt env'           -l env            -d 'show the env-variables used'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt lsp-version'   -l lsp-version   -d 'show the npm package for the lsp-version'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt capabilities'  -l capabilities   -d 'show the lsp capabilities implemented' 
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt man-file'      -l man-file       -d 'show man file path'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt logs-file'     -l logs-file      -d 'show logs.txt file path'
complete -c fish-lsp -n '__fish_lsp_using_command info; and not __fish_contains_opt more'          -l more           -d 'show more info'

# fish-lsp logger --<TAB>
complete -c fish-lsp -n __fish_use_subcommand -x -a logger -d 'logger utilities'
complete -c fish-lsp -n '__fish_lsp_using_command logger; and not __fish_contains_opt -s s show'  -s s -l show   -d 'show the "logs.txt" file'
complete -c fish-lsp -n '__fish_lsp_using_command logger; and not __fish_contains_opt -s c clear' -s c -l clear  -d 'clear the "logs.txt" file'
complete -c fish-lsp -n '__fish_lsp_using_command logger; and not __fish_contains_opt -s q quiet' -s q -l quiet  -d 'only write to "logs.txt" file'
complete -c fish-lsp -n '__fish_lsp_using_command logger; and not __fish_contains_opt -s d date'  -s d -l date   -d 'write date to "logs.txt" file'
complete -c fish-lsp -n '__fish_lsp_using_command logger; and not __fish_contains_opt config'          -l config -d 'show the logger config'

# print all $fish_lsp_submcommands
function _fish_lsp_get_features
  printf %b\n complete hover rename reference formatting codeAction codeLens folding signature executeCommand inlayHint highlight diagnostic
end

# fish-lsp env --<TAB>
complete -c fish-lsp -n __fish_use_subcommand -x -a env -d 'generate fish shell env variables to be used by lsp'
complete -c fish-lsp -n '__fish_lsp_using_command env; and not __fish_contains_opt -s s show; and not __fish_contains_opt -s c create' -s s -l show        -d 'show the current fish-lsp env variables'
complete -c fish-lsp -n '__fish_lsp_using_command env; and not __fish_contains_opt -s c create; and not __fish_contains_opt -s s show' -s c -l create      -d 'build initial fish-lsp env variables'
complete -c fish-lsp -n '__fish_lsp_using_command env; and not __fish_contains_opt no-comments'                                             -l no-comments -d 'skip outputting comments'

# COMPLETION: fish-lsp subcmd <option> [VALUE] (`fish-lsp start --enable ...`)
complete -c fish-lsp -n '__fish_seen_subcommand_from $__fish_lsp_subcommands' -l enable -xa '(_fish_lsp_get_features)'
complete -c fish-lsp -n '__fish_seen_subcommand_from $__fish_lsp_subcommands' -l disable -xa '(_fish_lsp_get_features)'

# built by the command: 
# fish-lsp complete ~/.config/fish/completions/fish-lsp.fish
