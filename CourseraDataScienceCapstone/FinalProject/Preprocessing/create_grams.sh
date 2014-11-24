########## CREATE 1 GRAMS #########

echo "Obtaining all words..."
cat all_clean | tr " " "\n" | sort | uniq --count > uniqueWords_tmp
sort -rn uniqueWords_tmp > uniqueWords
rm uniqueWords_tmp
#remove first line (the one that counts whitespaces)
sed -i 1d uniqueWords

	
########## CREATE 2 GRAMS #########

echo "Creating 2 grams...";

cat all_clean |  awk '{
n=split($0,a," "); 
for(i=1;i<(n-1);i++){
if ( length(a[i])<12 && length(a[i+1])<12 )
print a[i]" " a[i+1];}
}' > grams2_tmp

echo "Counting 2 grams...";

cat grams2_tmp | sort | uniq --count  >  grams2Count
rm grams2_tmp

########## CREATE 3 GRAMS #########

echo "Creating 3 grams...";

cat all_clean |  awk '{
n=split($0,a," "); 
for(i=1;i<(n-3);i++){
if ( length(a[i])<12 && length(a[i+1])<12 && length(a[i+2])<12)
print a[i]" " a[i+1]" " a[i+2];}
}' > grams3_tmp

echo "Counting 3 grams...";

#The 3-grams needed are the ones whose last 2 words are duplicated (if they aren't we have to search in the 2-gram table anyway)
#We do the following:
#- sort by 2nd and 3rd column 
#- print only duplicates: "-D" (in capital letters) prints only duplicates as many times as there are occurrences; -f 1 we skip first field
#- sort, count and print in file grams3Count
cat grams3_tmp | sort  -k 2,3 | uniq -D -f 1 | sort | uniq --count >  grams3Count
rm grams3_tmp


########## SORT 3-GRAMS AND 2-GRAMS #########
echo "Sorting 3-grams"
sort -r -n grams3Count > grams3Count_tmp
mv grams3Count_tmp grams3Count



echo "Sorting 2-grams"
sort -r -n grams2Count > grams2Count_tmp
mv grams2Count_tmp grams2Count



