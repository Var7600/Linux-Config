#Script de sauvegarde de fichier de suppression
# @auteur original @Christophe blaess
# version modifie 

sauvegarde_rm=~/rm_saved/

function rm
{
	local opt_force=0
	local opt_interactive=0
	local opt_recursive=0
	local opt_verbose=0
	local opt_empty=0
	local opt_list=0
	local opt_restore=0
  local opt
    
  OPTIND=0
#Analyse des arguments de la ligne de commande
	while getopts ":dfirRvels-:" opt ; do
		case $opt in 
		d) ;; #ignoree
		f) opt_force=1 ;;
		i) opt_interactive=1;;
		r | R ) opt_recursive=1;;
		e ) opt_empty=1;;
		l) opt_list=1;;
		s) opt_restore=1;;
		v)opt_verbose=1;;
		-) case $OPTARGS in #gestion option longue
				directory ) ;;
				force) opt_force=1;;
				interactive) opt_interactive=1;;
				recursive) opt_recursive=1;;
				verbose) opt_verbose=1 ;;
				help) /bin/rm --help
					echo "rm_secure:"
					echo " -e --empty vider la corbeille"
					echo " -l --list voir les fichiers sauves"
					echo " -s, --restore recuperer des fichiers"
					return 0;; #code de retour du commande rm
			 version ) /bin/rm --version
					echo "(rm_secure 1.2)"
					return 0 ;;
				#default option
				empty ) opt_empty=1 ;;
				list ) opt_list=1 ;;
				restore) opt_restore=1;;
				* ) echo "option illegale -- $OPTARG" #option non traites
							return 1;;#erreur
			esac ;;
			? ) echo "option illegale -- $OPTARG"
					return 1;;
		esac
	done
		# OPTIND indice des arguments fournies si ts ls arguments sont fournis elle est a n + 1
	shift "$($OPTIND -1)" # shift n decale les arguments en supprimant les n premiers

	#Creer eventuellement le repertoire
	if [ ! -d "$sauvegarde_rm" ] ; then
		mkdir "$sauvegarde_rm"
	fi
#vider la poubelle
	if [ $opt_empty -ne 0 ] ; then
		/bin/rm -rf "sauvegarde_rm"
		return 0
	fi
#liste des fichiers sauves
	if [ $opt_list -ne 0 ]; then
		( cd "$sauvegarde_rm" || exit 
		ls -lRa ./*)
	fi
#recuperation de fichiers
	if [ $opt_restore -ne 0 ] ; then
		while [ -n "$1" ] ; do
			mv "${sauvegarde_rm}/$1"
			shift
		done
		return
	fi
#suppresion de fichiers
	while [ -n "$1" ]; do
#suppersion interactive : interroger l'utilisateur
		if [ $opt_force -ne 1 ] && [ $opt_interactive -ne 0 ]
			then
			local reponse
			echo -n "Detruire $1 ?"
			read -r response
			if [ "$response" != 'y' ] && [ "$response" != "Y" ] &&
			   [ "$reponse" != "o" ] && [ "$reponse" != "O" ]; then
				shift #sert a eliminer ce qu'on vient de traiter
				continue
			fi
		fi
		#les repertoires necessitent l'option recursive
		if [ -d "$1" ] && [ $opt_recursive -eq 0 ] ; then
			shift
			continue
		fi
		if [ $opt_verbose -ne 0 ] ; then
			echo "Suppression $1"
			echo "sauvegarde dans $sauvegarde_rm"
		fi
		mv -f "$1" "${sauvegarde_rm}/"
		shift
	done
	
}
trap '/bin/rm -rf $sauvegarde_rm' EXIT #la commande trap permet la gestion minimale des signaux
