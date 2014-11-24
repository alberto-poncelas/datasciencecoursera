Coursera Data Science Capstone
========================================================
css: styles.css 
## Final project
author: Alberto Poncelas


 
Index
========================================================
class: index
<div style="font-size:15px"><i> The presentation </i></div>
- Cover 
- Index

<div style="font-size:15px"><i> App instructions </i></div>

- Using the app

<div style="font-size:15px"><i> The app inside </i></div>
- Preprocessing data
- The algorithm
- Future work



Using the app
========================================================

Once the app is completely loaded, a textbox will appear where you can type your sentence.

Below the box it is displayed the sentence the app is trying to predict:

1. While you are writing: the app will try to predict the word you are typing at the moment. 

2. Once you press spacebar: the app will try to predict the next word in the sentence.

<div style="font-size:20px"><i> Hint: If you type underscore ("_" character) the app will autocomplete the word you are typing with the predicted one. </i></div>


Preprocessing data
========================================================

The data preprocessing consisted in three main parts:

1. <b>Data cleaning</b>: Concatenate "news", "blogs" and "twitter" data in a single text and format it so it has one sentence each line. Then remove unwanted characters such as # or @.
2. <b>n-grams creation</b>: Create different files with the n-grams and their number of ocurrences. For doing that so, AWK scripting have been used.
3. <b>Data reduction</b>: Delete redundant information. For example, if there is only one ocurrence of the 2-gram  $(w_a,w_b)$, then we can ignore all 3-gram containing this pair of words as we already know the occurrence of each one will be also 1.


The algorithm
========================================================
### Predicting a new word
Given a sentence, an ordered set of $n$ words: $(w_{1},...,w_{n-1},w_{n})$.

We want to find $w_i$ that maximizes de following probability.
$$P(w_i|w_{n-1},w_{n}) $$ 
If we cannot find any word (because sentence is not long enough or we do not have enough data) then 
we try the following.
 $$P(w_i|w_{n}) $$
 
### Predicting the word you are typing
Given a string $s$ try to find the word $w_k$ maximizes:
$P(w_k)$ restricted to: first_letters( $w_k$ )=$s$


Future work
========================================================
class: future_work
In this project time consumption has been the highest priority. For this reason, other potentially good but slower approaches have been rejected. Nevertheless, here we explain other ideas that may be included in future work.

### Use more n-grams

Try to improve prediction by  searching in 4-grams, 5-grams...

### Word distances

The predictions might have been improved by predicting words related with the topic of the sentence. For doing that we could define a matrix with word distances:

We can calculate the distance between two words $w_i$ and $w_j$ as: $$d_{w_i,w_j}=|pos(w_i)-pos(w_j)|$$ 

Where $w_i$ and $w_j$ are two words that belong to a ordered set of words $(w_{1},...,w_{n-1},w_{n})$ and the function $pos(w_k)$ is defined as: $pos(w_k)=k$.








 
