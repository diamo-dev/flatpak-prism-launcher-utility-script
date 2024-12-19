kill_prism()
{
	echo "Killing Prism Launcher ..."
	kill prismrun
	echo "Done."
}
prompt_fixed()
{
	local isfixed=""
	while : ; do
		read -p "Is the issue fixed? (Y/n): " isfixed
		if [ "$isfixed" == "y" ] || [ "$isfixed" == "" ]; then
			return 1
		else
			if [ "$isfixed" == "n" ]; then
				return 0
			fi
		fi
	done
}
kill_prism
echo "Updating Flatpaks..."
flatpak update --noninteractive
echo "Done."
prompt_fixed
if [ "$?" == "1" ]; then
	exit
else
	kill_prism
fi
delete_cache()
{
	echo "Deleting \$PRISMROOT/metacache ..."
	rm -rf ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/metacache
	echo "Deleting \$PRISMROOT/meta ..."
	rm -rf ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/meta
	echo "Done."
}
delete_cache
prompt_fixed
if [ "$?" == "1" ]; then
	exit
else
	kill_prism
fi
delete_cache
echo "Deleting \$PRISMROOT/accounts.json ..."
rm -rf ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/accounts.json
echo "Done."
echo "You will have to log in to your Microsoft account again."
