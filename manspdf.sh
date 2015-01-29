#!/bin/bash
# Creates a big pdf of all man pages 
# in linux.

#   manspdf.sh - Create a pdf of all man pages.
#   (c) Abhilash Mhaisne 2014. abhilashmhaisne@gmail.com
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

cd /home/$USER

if [  ! -d __allmanpdfs ]; then #Create a directory 
	mkdir __allmanpdfs 
fi

cd __allmanpdfs    #Removes anything inside that
rm ./*.pdf		   #directory.
ls
cd ..

# 1] COMMANDS IN /etc

cd /home/$USER/__allmanpdfs

mkdir etcpdfs

cd /etc		  
#I used 2 commands, ps2pdf and pdfunite
for DIR in *	   
do
	man $DIR > /dev/null
	if  [ $? -ne 16 ]; then
		man -t $DIR | ps2pdf - > /home/$USER/__allmanpdfs/etcpdfs/$DIR.pdf
	fi
done 
#ps2pdf converts man page to pdf
cd /home/$USER/__allmanpdfs/etcpdfs

pdfunite *.pdf etcpdfs.pdf

cp etcpdfs.pdf ../

# 2] COMMANDS IN /usr/bin

cd /home/$USER/__allmanpdfs

mkdir usrbinpdfs

cd /usr/bin            

for DIR in *       
do
        man $DIR > /dev/null
        if  [ $? -ne 16 ]; then
                man -t $DIR | ps2pdf - > /home/$USER/__allmanpdfs/usrbinpdfs/$DIR.pdf
        fi
done

cd /home/$USER/__allmanpdfs/usrbinpdfs

pdfunite *.pdf usrbinpdfs.pdf
#Joins all pdf in a single pdf
cp usrbinpdfs.pdf ../

# 3] COMMANDS IN /bin

#Most of the commands are located in /bin, /usr/bin, /etc

cd /home/$USER/__allmanpdfs

mkdir binpdfs

cd /bin        

for DIR in *       
do
        man $DIR > /dev/null
        if  [ $? -ne 16 ]; then
		if [ ! -e $DIR.pdf ]; then
                	man -t $DIR | ps2pdf - > /home/$USER/__allmanpdfs/binpdfs/$DIR.pdf
        	fi
	fi
done

cd /home/$USER/__allmanpdfs/binpdfs

pdfunite *.pdf binpdfs.pdf

cp binpdfs.pdf ../


cd /home/$USER/__allmanpdfs

pdfunite *.pdf allmans.pdf

#Comment the following lines if you want all pdfs seperate along with the big one

rmdir binpdfs etcpdfs usrbinpdfs
