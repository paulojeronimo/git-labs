git init
echo "a" > a.txt
git add a.txt
git commit -m 'Added a.txt'
git checkout -b fbranch
for f in b c d e f g
do
  echo $f > "$f.txt"
done
git add b.txt c.txt
git commit -m 'Added {b,c}.txt'
git add d.txt
git commit -m 'Added d.txt'
git add {e,f,g}.txt
git commit -m 'Added {e,f,g}.txt'
git log --oneline

git checkout master
git log --oneline
