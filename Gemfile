source "http://rubygems.org"

gem "activerecord", "~>3.0"
gem "sqlite3"
gem "twitter", "~>1.0.0.rc"

platforms :ruby do
  group :bayes do
    gem "ankusa"
  end
  
  group :svm do
    gem "colorize"
    gem "eluka"
  end
end

platforms :jruby do
  group :maxent do
    gem "maxent_string_classifier", :git => "git://github.com/matid/maxent_string_classifier.git"
  end
end
