#!/bin/bash

echo -e "----------------------------------------"
echo -e "                                        "
echo -e "DirectAdmin backup to cPanel restoration"
echo -e "              	                         "
echo -e "----------------------------------------"
echo -e "              	                         "
echo -e "Written by: the3x0rcist"
echo -e "              	                         "
echo -e "----------------------------------------"
echo -e "\n"
                                                                                                                                                                                                                          
# usage: ./directadmin_restore.sh <backup> <user>


file=$1
user=$2

if [ $# -lt 1 ]; then
	
	echo "Usage: ./directamdin_restore.sh <backup> <user>"
	echo -e "\n"
	exit 1
fi

if ! [ -f $1 ]; then
	echo -e "An error has been occured, The file: '$file' does not exist.\nPlease enter a valid file!"
	exit 1
fi

if tar -tf $file | grep -q "domains"; then

	echo -e "Unzipping the file\nThis may take a few minutes..."
	tar -xf $file
	echo -e "File has been successfully unzipped!"
else 
	echo -e "Not a directadmin backup"
fi
	

# Restoring the files...
echo "Restoring your backup please wait..."

if cd /home/$user/domains/public_html && mv * /home/$user/public_html/ 2> /dev/null; then
  echo -e "Files moved successfully."
else
  echo -e "An error occurred while moving files."
 
fi

echo -e "Enter the database user: "
read mysql_user
echo -e "Enter the database name: "
read mysql_database
echo -e "Enter the name of the SQL file to import: "
read sql_file
if mysql -u $mysql_user -p $mysql_database < /home/$user/backups/$sql_file; then
	echo -e "$sql_file has successfully imported to $mysql_database"
else
	echo -e "Cannot import the database :("
fi

echo "Goodbye FRIEND :)"

