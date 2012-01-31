rm -rf /tmp/hello
git init /tmp/hello
cd /tmp/hello
echo 'Goodbye, World!' > hello.txt
git add hello.txt
git commit -m 'Initial import.'
echo 'Hello, World!' > hello.txt
git add .
git commit -m 'Update on trunk.'
git checkout -b branch
git mv hello.txt hello.en.txt
git add .
git commit -m 'Rename.'
git checkout master
git merge branch
