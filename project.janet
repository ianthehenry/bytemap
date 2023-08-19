(declare-project
  :name "bytemap"
  :description "text-based canvas"
  :version "0.0.0"
  :dependencies
    ["https://github.com/ianthehenry/judge.git"])

(declare-source
  :prefix "bytemap"
  :source ["src/init.janet"
           "src/util.janet"])
