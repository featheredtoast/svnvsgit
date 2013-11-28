rm -rf /tmp/hello
mkdir /tmp/hello
cd /tmp/hello
svnadmin create /tmp/hello/repo
svn checkout file:///tmp/hello/repo test
cd test
mkdir trunk branches
echo "some text in myFile" > trunk/myFile
svn add trunk branches
svn commit -m 'Initial import.'

# work on some product a that has common libraries
svn copy -m 'creating branch A' file:///tmp/hello/repo/trunk \
         file:///tmp/hello/repo/branches/productA-1.0

# work on some product B that has common libraries.
svn copy -m 'creating branch B' file:///tmp/hello/repo/trunk \
         file:///tmp/hello/repo/branches/productB-1.0

# while we are at it, start a beta that combines both products.
svn copy -m 'creating branch combined' file:///tmp/hello/repo/trunk \
         file:///tmp/hello/repo/branches/combinedBeta

cd ..
svn checkout file:///tmp/hello/repo/trunk project

cd project
svn switch ^/branches/productA-1.0
echo "productA added a file" > productA_added
svn add productA_added
svn commit -m 'added file to productA'

svn switch ^/branches/combinedBeta
svn merge ^/branches/productA-1.0 .
svn commit -m "merge from productA-1.0 to beta"

svn switch ^/branches/productB-1.0
echo "productB-1.0 added" > productB-1.0_added
svn add productB-1.0_added
svn commit -m 'added file to productB'

svn switch ^/branches/combinedBeta
svn up
svn merge ^/branches/productB-1.0 .
svn commit -m "merge from productB-1.0 to beta"

svn switch ^/trunk

svn up
svn merge ^/branches/productA-1.0 .
svn commit -m "merge from productA-1.0 to trunk"


svn up
svn merge ^/branches/productB-1.0 .
svn commit -m "merge from productB-1.0 to trunk"

svn switch ^/branches/combinedBeta
echo "integration with a" >> productB-1.0_added
svn commit -m 'better integration between features'

svn switch ^/trunk
svn up
echo 'svn mergeinfo:'
svn pg svn:mergeinfo
echo ''

svn merge ^/branches/combinedBeta .

echo 'svn mergeinfo:'
svn pg svn:mergeinfo
