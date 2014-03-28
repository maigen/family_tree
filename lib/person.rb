class Person < ActiveRecord::Base
  belongs_to :spouse, class_name: "Person"
  # belongs_to :parents, class_name: "Person"

  validates :name, :presence => true
  # has_many :parents, class_name: "Person",
  #                    foreign_key: "id"



  # after_save :make_marriage_reciprocal


#   def spouse
#     if spouse_id.nil?
#       nil
#     else
#       Person.find(spouse_id)
#     end
#   end

# private

#   def make_marriage_reciprocal
#     if spouse_id_changed?
#       spouse.update(:spouse_id => id)
#     end
#   end
end

