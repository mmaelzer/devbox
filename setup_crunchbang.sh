# Backup old ~/.config/terminator/config file
config_file=$HOME/.config/terminator/config
config_file_bak=$config_file"_bak"
new_config=$(pwd)/os/crunchbang/.config/terminator/config 

if [ -e $config_file ]; then
  echo "Backing up config file $config_file to $config_file_bak"
  mv $config_file $config_file_bak
else
  echo "No config file $config_file found. Adding custom config file."
fi

# Add custom config file
cp $new_config $config_file
echo "Copied $new_config to $config_file"
