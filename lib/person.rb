class Person < ActiveRecord::Base
  belongs_to :spouse, class_name: "Person"
  validates :name, :presence => true

  after_save :make_marriage_reciprocal


  def spouse
    if spouse_id.nil?
      nil
    else
      Person.find(spouse_id)
    end
  end

  def find_children
    found_children = []
    Person.all.each do |potential_child|
      if potential_child.parent_id_1 == self.id || potential_child.parent_id_2 == self.id
        found_children << potential_child.name
      end
    end
    found_children
  end

  def find_parents
    parents = []
    parents << Person.where(:id => self.parent_id_1).first
    parents << Person.where(:id => self.parent_id_2).first
    parents
  end

  def find_grandparents
    grandparents = []
    parents = self.find_parents
    parents.each do |parent|
        grandparents << parent.find_parents if !parent.find_parents.nil?
      end
    grandparents.flatten
  end

private

  def make_marriage_reciprocal
    if spouse_id_changed?
      spouse.update(:spouse_id => id)
    end
  end
end

