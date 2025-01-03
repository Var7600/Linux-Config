# Script to save files or directories when deleted
# @original author @Christophe blaess
# this is modified version from the orginal one author Var600(Doudou)

# recovery folder path
sauvegarde_rm=~/rm_saved/
# default retention period is 60 days
days=60

function rm {
    local opt_force=0
    local opt_interactive=0
    local opt_recursive=0
    local opt_verbose=0
    local opt_empty=0
    local opt_list=0
    local opt_restore=0
		local override_days=0
    local opt

    OPTIND=0
    # process command line argument
    while getopts ":dfirRvels-:" opt ; do
        case $opt in
        d) override_days=$OPTARG ;; 
        f) opt_force=1 ;;
        i) opt_interactive=1 ;;
        r | R ) opt_recursive=1 ;;
        e ) opt_empty=1 ;;
        l) opt_list=1 ;;
        s) opt_restore=1 ;;
        v) opt_verbose=1 ;;
        -) case $OPTARG in
                directory ) ;;
                force) opt_force=1 ;;
                interactive) opt_interactive=1 ;;
                recursive) opt_recursive=1 ;;
                verbose) opt_verbose=1 ;;
                help) 
                    /bin/rm --help
                    echo "rm_secure:"
										echo "-d <days> --specify retention period in days"
                    echo " -e --empty save folder"
                    echo " -l --list file(s) in the saved folder"
                    echo " -s, --restore from the save folder"
                    return 0 ;; # exit code for rm
                version ) 
                    /bin/rm --version
                    echo "(rm_secure 1.3)"
                    return 0 ;;
                # default option
                empty ) opt_empty=1 ;;
                list ) opt_list=1 ;;
                restore) opt_restore=1 ;;
                * ) echo "unknow option -- $OPTARG" # option invalid 
                    return 1 ;; # error 
            esac ;;
        ? ) echo "illegal option -- $OPTARG"
            return 1 ;;
        esac
    done

    shift $((OPTIND - 1)) # shifts the arguments by removing the first n
		
		# set retention period
		local retention_period=${days:-$override_days}


    # create the backup directory
    if [ ! -d "$sauvegarde_rm" ]; then
        mkdir "$sauvegarde_rm"
    fi

    # empty trash
    if [ $opt_empty -ne 0 ]; then
        /bin/rm -rf "{$sauvegarde_rm:?}/"*  # Empty the trash
        return 0
    fi

    # list files in the trash
    if [ $opt_list -ne 0 ]; then
        ( cd "$sauvegarde_rm" &&  ls -lRa ./)
    fi

    # restore trash files
    if [ $opt_restore -ne 0 ]; then
        while [ -n "$1" ]; do
            mv "${sauvegarde_rm}/$1" "$1"
            shift
        done
        return
    fi
		
		# delete files after retention period
		find "$sauvegarde_rm" -mindepth 1 -type f -mtime +$retention_period -exec /bin/rm -f {} \;

    # delete
    while [ -n "$1" ]; do
        # delete interactive mode 
        if [ $opt_force -ne 1 ] && [ $opt_interactive -ne 0 ]; then
            local response
            echo -n "Delete $1?[y/n]: "
            read -r response
            if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
                shift # delete
                continue
            fi
        fi

        # for deleting a directory
        if [ -d "$1" ] && [ $opt_recursive -eq 0 ]; then
            echo "$1 is a Directory please use -r or -R option."
            shift
            continue
        fi

        if [ $opt_verbose -ne 0 ]; then
					echo "deleting $1 (Saved in $sauvegarde_rm)"
        fi

				timestamp=$(date +%Y%m%d%H%M%S)
				mv -f "$1" "${sauvegarde_rm}/${timestamp}_$(basename "$1")"
        shift
    done
}

trap '/bin/rm -rf "$sauvegarde_rm"' EXIT # to handle signals

