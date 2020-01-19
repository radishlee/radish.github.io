pid=`ps -fe | grep jekyll  | grep -v grep | awk '{print $2}'`
kill -9 $pid

bundle install
nohup bundle exec jekyll serve &
