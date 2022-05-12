complete -c deno -n "__fish_use_subcommand" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_use_subcommand" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_use_subcommand" -s V -l version -d 'Print version information'
complete -c deno -n "__fish_use_subcommand" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_use_subcommand" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_use_subcommand" -f -a "bench" -d 'Run benchmarks'
complete -c deno -n "__fish_use_subcommand" -f -a "bundle" -d 'Bundle module and dependencies into single file'
complete -c deno -n "__fish_use_subcommand" -f -a "cache" -d 'Cache the dependencies'
complete -c deno -n "__fish_use_subcommand" -f -a "compile" -d 'UNSTABLE: Compile the script into a self contained executable'
complete -c deno -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions'
complete -c deno -n "__fish_use_subcommand" -f -a "coverage" -d 'Print coverage reports'
complete -c deno -n "__fish_use_subcommand" -f -a "doc" -d 'Show documentation for a module'
complete -c deno -n "__fish_use_subcommand" -f -a "eval" -d 'Eval script'
complete -c deno -n "__fish_use_subcommand" -f -a "fmt" -d 'Format source files'
complete -c deno -n "__fish_use_subcommand" -f -a "info" -d 'Show info about cache or info related to source file'
complete -c deno -n "__fish_use_subcommand" -f -a "install" -d 'Install script as an executable'
complete -c deno -n "__fish_use_subcommand" -f -a "uninstall" -d 'Uninstall a script previously installed with deno install'
complete -c deno -n "__fish_use_subcommand" -f -a "lsp" -d 'Start the language server'
complete -c deno -n "__fish_use_subcommand" -f -a "lint" -d 'Lint source files'
complete -c deno -n "__fish_use_subcommand" -f -a "repl" -d 'Read Eval Print Loop'
complete -c deno -n "__fish_use_subcommand" -f -a "run" -d 'Run a JavaScript or TypeScript program'
complete -c deno -n "__fish_use_subcommand" -f -a "task" -d 'Run a task defined in the configuration file'
complete -c deno -n "__fish_use_subcommand" -f -a "test" -d 'Run tests'
complete -c deno -n "__fish_use_subcommand" -f -a "types" -d 'Print runtime TypeScript declarations'
complete -c deno -n "__fish_use_subcommand" -f -a "upgrade" -d 'Upgrade deno executable to given version'
complete -c deno -n "__fish_use_subcommand" -f -a "vendor" -d 'Vendor remote modules into a local directory'
complete -c deno -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c deno -n "__fish_seen_subcommand_from bench" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-read -d 'Allow file system read access' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-write -d 'Allow file system write access' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-net -d 'Allow network access' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-env -d 'Allow environment access' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-run -d 'Allow running subprocesses' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-ffi -d 'Allow loading dynamic libraries' -r -F
complete -c deno -n "__fish_seen_subcommand_from bench" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from bench" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l ignore -d 'Ignore files' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -l filter -d 'Run benchmarks with this string or pattern in the bench name' -r
complete -c deno -n "__fish_seen_subcommand_from bench" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from bench" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from bench" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from bench" -l allow-hrtime -d 'Allow high resolution time measurement'
complete -c deno -n "__fish_seen_subcommand_from bench" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_seen_subcommand_from bench" -l prompt -d 'deprecated: Fallback to prompt if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from bench" -l no-prompt -d 'Always throw if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from bench" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from bench" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from bench" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from bench" -l watch -d 'UNSTABLE: Watch for file changes and restart process automatically'
complete -c deno -n "__fish_seen_subcommand_from bench" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_seen_subcommand_from bench" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from bench" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from bench" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from bundle" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bundle" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bundle" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from bundle" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from bundle" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bundle" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from bundle" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from bundle" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from bundle" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from bundle" -l watch -d 'UNSTABLE: Watch for file changes and restart process automatically'
complete -c deno -n "__fish_seen_subcommand_from bundle" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_seen_subcommand_from bundle" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from bundle" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from bundle" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from cache" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from cache" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from cache" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from cache" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from cache" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from cache" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from cache" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from cache" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from cache" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from cache" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from cache" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from cache" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from compile" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-read -d 'Allow file system read access' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-write -d 'Allow file system write access' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-net -d 'Allow network access' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-env -d 'Allow environment access' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-run -d 'Allow running subprocesses' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-ffi -d 'Allow loading dynamic libraries' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from compile" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from compile" -s o -l output -d 'Output file (defaults to $PWD/<inferred-name>)' -r -F
complete -c deno -n "__fish_seen_subcommand_from compile" -l target -d 'Target OS architecture' -r -f -a "{x86_64-unknown-linux-gnu	,x86_64-pc-windows-msvc	,x86_64-apple-darwin	,aarch64-apple-darwin	}"
complete -c deno -n "__fish_seen_subcommand_from compile" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from compile" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from compile" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from compile" -l allow-hrtime -d 'Allow high resolution time measurement'
complete -c deno -n "__fish_seen_subcommand_from compile" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_seen_subcommand_from compile" -l prompt -d 'deprecated: Fallback to prompt if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from compile" -l no-prompt -d 'Always throw if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from compile" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from compile" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from compile" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from compile" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from compile" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from compile" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from completions" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from completions" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from completions" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from coverage" -l ignore -d 'Ignore coverage files' -r -F
complete -c deno -n "__fish_seen_subcommand_from coverage" -l include -d 'Include source files in the report' -r
complete -c deno -n "__fish_seen_subcommand_from coverage" -l exclude -d 'Exclude source files from the report' -r
complete -c deno -n "__fish_seen_subcommand_from coverage" -l output -d 'Output file (defaults to stdout) for lcov' -r -F
complete -c deno -n "__fish_seen_subcommand_from coverage" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from coverage" -l lcov -d 'Output coverage report in lcov format'
complete -c deno -n "__fish_seen_subcommand_from coverage" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from coverage" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from coverage" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from doc" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from doc" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from doc" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from doc" -l json -d 'Output documentation in JSON format'
complete -c deno -n "__fish_seen_subcommand_from doc" -l private -d 'Output private documentation'
complete -c deno -n "__fish_seen_subcommand_from doc" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from doc" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from doc" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from eval" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from eval" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from eval" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from eval" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from eval" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from eval" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from eval" -l inspect -d 'Activate inspector on host:port (default: 127.0.0.1:9229)' -r
complete -c deno -n "__fish_seen_subcommand_from eval" -l inspect-brk -d 'Activate inspector on host:port and break at start of user script' -r
complete -c deno -n "__fish_seen_subcommand_from eval" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from eval" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from eval" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from eval" -l ext -d 'Set standard input (stdin) content type' -r -f -a "{ts	,tsx	,js	,jsx	}"
complete -c deno -n "__fish_seen_subcommand_from eval" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from eval" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from eval" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from eval" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from eval" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from eval" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from eval" -s T -l ts -d 'Treat eval input as TypeScript'
complete -c deno -n "__fish_seen_subcommand_from eval" -s p -l print -d 'print result to stdout'
complete -c deno -n "__fish_seen_subcommand_from eval" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from eval" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from eval" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from fmt" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from fmt" -l ext -d 'Set standard input (stdin) content type' -r -f -a "{ts	,tsx	,js	,jsx	,md	,json	,jsonc	}"
complete -c deno -n "__fish_seen_subcommand_from fmt" -l ignore -d 'Ignore formatting particular source files' -r -F
complete -c deno -n "__fish_seen_subcommand_from fmt" -l options-line-width -d 'Define maximum line width. Defaults to 80.' -r
complete -c deno -n "__fish_seen_subcommand_from fmt" -l options-indent-width -d 'Define indentation width. Defaults to 2.' -r
complete -c deno -n "__fish_seen_subcommand_from fmt" -l options-prose-wrap -d 'Define how prose should be wrapped. Defaults to always.' -r -f -a "{always	,never	,preserve	}"
complete -c deno -n "__fish_seen_subcommand_from fmt" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from fmt" -l check -d 'Check if the source files are formatted'
complete -c deno -n "__fish_seen_subcommand_from fmt" -l watch -d 'UNSTABLE: Watch for file changes and restart process automatically'
complete -c deno -n "__fish_seen_subcommand_from fmt" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_seen_subcommand_from fmt" -l options-use-tabs -d 'Use tabs instead of spaces for indentation. Defaults to false.'
complete -c deno -n "__fish_seen_subcommand_from fmt" -l options-single-quote -d 'Use single quotes. Defaults to false.'
complete -c deno -n "__fish_seen_subcommand_from fmt" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from fmt" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from fmt" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from info" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from info" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from info" -l location -d 'Show files used for origin bound APIs like the Web Storage API when running a script with \'--location=<HREF>\'' -r -f
complete -c deno -n "__fish_seen_subcommand_from info" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from info" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from info" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from info" -l json -d 'UNSTABLE: Outputs the information in JSON format'
complete -c deno -n "__fish_seen_subcommand_from info" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from info" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from info" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from install" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from install" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-read -d 'Allow file system read access' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-write -d 'Allow file system write access' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-net -d 'Allow network access' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-env -d 'Allow environment access' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-run -d 'Allow running subprocesses' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-ffi -d 'Allow loading dynamic libraries' -r -F
complete -c deno -n "__fish_seen_subcommand_from install" -l inspect -d 'Activate inspector on host:port (default: 127.0.0.1:9229)' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l inspect-brk -d 'Activate inspector on host:port and break at start of user script' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from install" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from install" -s n -l name -d 'Executable file name' -r
complete -c deno -n "__fish_seen_subcommand_from install" -l root -d 'Installation root' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_seen_subcommand_from install" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from install" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from install" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from install" -l allow-hrtime -d 'Allow high resolution time measurement'
complete -c deno -n "__fish_seen_subcommand_from install" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_seen_subcommand_from install" -l prompt -d 'deprecated: Fallback to prompt if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from install" -l no-prompt -d 'Always throw if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from install" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from install" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from install" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from install" -s f -l force -d 'Forcefully overwrite existing installation'
complete -c deno -n "__fish_seen_subcommand_from install" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from install" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from install" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from uninstall" -l root -d 'Installation root' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_seen_subcommand_from uninstall" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from uninstall" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from uninstall" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from uninstall" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from lsp" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from lsp" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from lsp" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from lsp" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from lint" -l rules-tags -d 'Use set of rules with a tag' -r
complete -c deno -n "__fish_seen_subcommand_from lint" -l rules-include -d 'Include lint rules' -r
complete -c deno -n "__fish_seen_subcommand_from lint" -l rules-exclude -d 'Exclude lint rules' -r
complete -c deno -n "__fish_seen_subcommand_from lint" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from lint" -l ignore -d 'Ignore linting particular source files' -r -F
complete -c deno -n "__fish_seen_subcommand_from lint" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from lint" -l rules -d 'List available rules'
complete -c deno -n "__fish_seen_subcommand_from lint" -l json -d 'Output lint result in JSON format'
complete -c deno -n "__fish_seen_subcommand_from lint" -l watch -d 'UNSTABLE: Watch for file changes and restart process automatically'
complete -c deno -n "__fish_seen_subcommand_from lint" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_seen_subcommand_from lint" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from lint" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from lint" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from repl" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from repl" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from repl" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from repl" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from repl" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from repl" -l inspect -d 'Activate inspector on host:port (default: 127.0.0.1:9229)' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -l inspect-brk -d 'Activate inspector on host:port and break at start of user script' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from repl" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -l eval -d 'Evaluates the provided code when the REPL starts.' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_seen_subcommand_from repl" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from repl" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from repl" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from repl" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from repl" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from repl" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from repl" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from repl" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from repl" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from run" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from run" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-read -d 'Allow file system read access' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-write -d 'Allow file system write access' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-net -d 'Allow network access' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-env -d 'Allow environment access' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-run -d 'Allow running subprocesses' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-ffi -d 'Allow loading dynamic libraries' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -l inspect -d 'Activate inspector on host:port (default: 127.0.0.1:9229)' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l inspect-brk -d 'Activate inspector on host:port and break at start of user script' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from run" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from run" -l watch -d 'UNSTABLE: Watch for file changes and restart process automatically' -r -F
complete -c deno -n "__fish_seen_subcommand_from run" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from run" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from run" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from run" -l allow-hrtime -d 'Allow high resolution time measurement'
complete -c deno -n "__fish_seen_subcommand_from run" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_seen_subcommand_from run" -l prompt -d 'deprecated: Fallback to prompt if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from run" -l no-prompt -d 'Always throw if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from run" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from run" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from run" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from run" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_seen_subcommand_from run" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from run" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from run" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from task" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from task" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from task" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from task" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from task" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from test" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l no-check -d 'Skip type checking modules' -r
complete -c deno -n "__fish_seen_subcommand_from test" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-read -d 'Allow file system read access' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-write -d 'Allow file system write access' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-net -d 'Allow network access' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-env -d 'Allow environment access' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-run -d 'Allow running subprocesses' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-ffi -d 'Allow loading dynamic libraries' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l inspect -d 'Activate inspector on host:port (default: 127.0.0.1:9229)' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l inspect-brk -d 'Activate inspector on host:port and break at start of user script' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l location -d 'Value of \'globalThis.location\' used by some web APIs' -r -f
complete -c deno -n "__fish_seen_subcommand_from test" -l v8-flags -d 'Set V8 command line options (for help: --v8-flags=--help)' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l seed -d 'Seed Math.random()' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l ignore -d 'Ignore files' -r -F
complete -c deno -n "__fish_seen_subcommand_from test" -l fail-fast -d 'Stop after N errors. Defaults to stopping after first failure.' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l filter -d 'Run tests with this string or pattern in the test name' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l shuffle -d '(UNSTABLE): Shuffle the order in which the tests are run' -r
complete -c deno -n "__fish_seen_subcommand_from test" -l coverage -d 'UNSTABLE: Collect coverage profile data into DIR' -r
complete -c deno -n "__fish_seen_subcommand_from test" -s j -l jobs -d 'Number of parallel workers, defaults to # of CPUs when no value is provided. Defaults to 1 when the option is not present.' -r
complete -c deno -n "__fish_seen_subcommand_from test" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from test" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_seen_subcommand_from test" -l lock-write -d 'Write lock file (use with --lock)'
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-hrtime -d 'Allow high resolution time measurement'
complete -c deno -n "__fish_seen_subcommand_from test" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_seen_subcommand_from test" -l prompt -d 'deprecated: Fallback to prompt if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from test" -l no-prompt -d 'Always throw if required permission wasn\'t passed'
complete -c deno -n "__fish_seen_subcommand_from test" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_seen_subcommand_from test" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_seen_subcommand_from test" -l compat -d 'Node compatibility mode. Currently only enables built-in node modules like \'fs\' and globals like \'process\'.'
complete -c deno -n "__fish_seen_subcommand_from test" -l no-run -d 'Cache test modules, but don\'t run tests'
complete -c deno -n "__fish_seen_subcommand_from test" -l trace-ops -d 'Enable tracing of async ops. Useful when debugging leaking ops in test, but impacts test execution time.'
complete -c deno -n "__fish_seen_subcommand_from test" -l doc -d 'UNSTABLE: type check code blocks'
complete -c deno -n "__fish_seen_subcommand_from test" -l allow-none -d 'Don\'t return error code if no test files are found'
complete -c deno -n "__fish_seen_subcommand_from test" -l watch -d 'UNSTABLE: Watch for file changes and restart process automatically'
complete -c deno -n "__fish_seen_subcommand_from test" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_seen_subcommand_from test" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from test" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from test" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from types" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from types" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from types" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from types" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from upgrade" -l version -d 'The version to upgrade to' -r
complete -c deno -n "__fish_seen_subcommand_from upgrade" -l output -d 'The path to output the updated version to' -r -F
complete -c deno -n "__fish_seen_subcommand_from upgrade" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from upgrade" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from upgrade" -l dry-run -d 'Perform all checks without replacing old exe'
complete -c deno -n "__fish_seen_subcommand_from upgrade" -s f -l force -d 'Replace current exe even if not out-of-date'
complete -c deno -n "__fish_seen_subcommand_from upgrade" -l canary -d 'Upgrade to canary builds'
complete -c deno -n "__fish_seen_subcommand_from upgrade" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from upgrade" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from upgrade" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from vendor" -l output -d 'The directory to output the vendored modules to' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_seen_subcommand_from vendor" -s c -l config -d 'Load configuration file' -r -F
complete -c deno -n "__fish_seen_subcommand_from vendor" -l import-map -d 'Load import map file' -r -F
complete -c deno -n "__fish_seen_subcommand_from vendor" -l lock -d 'Check the specified lock file' -r -F
complete -c deno -n "__fish_seen_subcommand_from vendor" -s r -l reload -d 'Reload source code cache (recompile TypeScript)' -r -F
complete -c deno -n "__fish_seen_subcommand_from vendor" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_seen_subcommand_from vendor" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from vendor" -s f -l force -d 'Forcefully overwrite conflicting files in existing output directory'
complete -c deno -n "__fish_seen_subcommand_from vendor" -s h -l help -d 'Print help information'
complete -c deno -n "__fish_seen_subcommand_from vendor" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from vendor" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_seen_subcommand_from help" -s L -l log-level -d 'Set log level' -r -f -a "{debug	,info	}"
complete -c deno -n "__fish_seen_subcommand_from help" -l unstable -d 'Enable unstable features and APIs'
complete -c deno -n "__fish_seen_subcommand_from help" -s q -l quiet -d 'Suppress diagnostic output'
