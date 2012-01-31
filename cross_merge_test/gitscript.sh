rm -rf /tmp/hello
git init /tmp/hello
cd /tmp/hello
echo "some text in myFile" > myFile
git add myFile
git commit -m "Adding myFile to trunk"

# work on some product a that has common libraries
git branch productA-1.0

# work on some product B that has common libraries.
git branch productB-1.0

# while we are at it, start a beta that combines both products.
git branch combinedBeta

git checkout productA-1.0
echo "productA added a file" > productA_added
git add productA_added
git commit -m "added file to productA"

git checkout combinedBeta
git merge productA-1.0

git checkout productB-1.0
echo "productB-1.0 added" > productB-1.0_added
git add productB-1.0_added
git commit -m "added file to productB"

git checkout combinedBeta
git merge productB-1.0

git checkout master
# merge product A back to trunk
git merge productA-1.0

# merge product B back to trunk.
git merge productB-1.0

#add some changes to combine features together or something 
git checkout combinedBeta
echo "integration with a">>productB-1.0_added
git add productB-1.0_added
git commit -m 'better integration between features'

# some time later, we are happy with the combined beta product
git checkout master
git merge combinedBeta
