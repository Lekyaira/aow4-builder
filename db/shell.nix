let
	pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
	# Other dependencies, cli tools, etc go here.
	buildInputs = with pkgs; [
		postgresql
		sqlx-cli
		jq
	];

	# Postgres
	PGDATA = ".dbdata";

	shellHook = ''
		#### Utils ####
		BINDIR=$PWD/bin 
		export PATH=$PATH:$BINDIR

		RED='\033[0;31m'
		GREEN='\033[0;32m'
		YELLOW='\033[0;33m'
		NC='\033[0m' # No Color

		#### Postgres ####
		# Create data directory if it does not exist and initialize it
		[ ! -d .dbdata ] && mkdir .dbdata && initdb
		
		printf "$GREEN\nUse 'start' to start Postgres server.\nUse 'stop' to stop Postgres server.\nUse 'sql' to start the Postgres cli.\n$NC"
		printf "$GREEN\nUse 'create_migration' to create a migration.\nUse 'migrate' to perform all pending migratons.\nUse 'revert_migration' to revert the last migration.\n\n$NC"
		'';
}
