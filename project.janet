(declare-project
  :name "bytemap"
  :description "text-based canvas"
  :version "0.0.0"
  :dependencies
    [{:url "https://github.com/ianthehenry/judge.git"
      :tag "v2.6.1"}])

(declare-source
  :prefix "bytemap"
  :source ["src/init.janet"
           "src/util.janet"])
