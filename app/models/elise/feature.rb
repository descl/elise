module Elise
  class Feature < Databaseformalizer::Entity
    acts_as_entity :Feature
    
    def find_by_label(label)
      Feature.all.find_all{|i|  i.label == label}[0]
    end
  end
end