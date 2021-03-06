task :compile => ["assets:precompile"] do
  def print_and_execute(cmd)
    puts "Executing: #{cmd}"
    ret = `#{cmd}`
    puts ret
    ret
  end
  
  def remove_from_gitignore(entry)
    print_and_execute("cat .gitignore | grep -v #{entry} > .gitignore.tmp; mv .gitignore.tmp .gitignore")
  end
  
  remove_from_gitignore("app/assets/images/happy-new-year-2010-11.jpg")
  remove_from_gitignore("app/assets/images/happy-new-year-2010-11-girls.jpg")
  remove_from_gitignore("app/assets/images/happy-new-year-2010-12.jpg")
  
  ["git add .",
   "git commit -m 'Compiled app ready for deploy'"
  ].each do |cmd|
     print_and_execute(cmd)
  end
  
  puts "To push to heroku, use:   git push -f heroku #{`git branch | grep '*' | cut -c 3-`.chomp}:master"
end