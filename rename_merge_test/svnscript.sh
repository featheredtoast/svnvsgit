rm -rf /tmp/hello
cd /tmp
svnadmin create /tmp/hello
svn checkout file:///tmp/hello test
cd test
mkdir trunk branches
echo 'Goodbye, World!' > trunk/hello.txt
svn add trunk branches
svn commit -m 'Initial import.'
svn copy file:///tmp/hello/trunk \
         file:///tmp/hello/branches/issue-2 -m 'Branch.'
cd ..
svn checkout file:///tmp/hello/trunk trunk
cd trunk
echo 'Hello, World!' > hello.txt
svn commit -m 'Update on trunk.'
cd ..
svn checkout file:///tmp/hello/branches/issue-2 issue-2
cd issue-2
svn rename hello.txt hello.en.txt
svn commit -m 'Rename on branch.'
cd ../trunk
svn update
svn merge --reintegrate file:///tmp/hello/branches/issue-2
