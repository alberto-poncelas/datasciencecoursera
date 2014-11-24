
#This script does the following:
# cat: takes the text passed by the parameter 
#| replaces "." by new line "\n" 
#| tolowercase 
#| delimiters to whitespaces 
#| awk (coge los pares)

#as output it creates a new file called "all_clean" with the cleaned text

echo "Cleaning text..."
cat $1 |  sed 's/\./ \n /g' | sed  's/./\L&/g' |  sed -r 's/[^a-z]/ /g' | sed -r 's/[[:space:]\":,;()@#?!]+/ /g'  > all_clean
echo "The file all_clean has been created"
