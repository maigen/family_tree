require 'spec_helper'

describe Person do
  it { should validate_presence_of :name }
  it { should belong_to :spouse }
  it { should have_many :parents }

  context '#spouse' do
    it 'returns the person with their spouse_id' do
      earl = Person.create(:name => 'Earl')
      steve = Person.create(:name => 'Steve')
      steve.update(:spouse_id => earl.id)
      steve.spouse.should eq earl
    end

    it "is nil if they aren't married" do
      earl = Person.create(:name => 'Earl')
      earl.spouse.should be_nil
    end
  end

  it "updates the spouse's id when its spouse_id is changed" do
    earl = Person.create(:name => 'Earl')
    steve = Person.create(:name => 'Steve')
    steve.update(:spouse_id => earl.id)
    earl.reload
    earl.spouse_id.should eq steve.id
  end

  it 'will return all the children for a parent' do
    earl = Person.create(:name => 'Earl')
    steve = Person.create(:name => 'Steve')
    stacey = Person.create(:name => 'Stacey', :parent_id_1  => earl.id)
    earl.find_children.should eq ['Stacey']
  end

  it 'will return the two parents for the inputted person' do
    earl = Person.create(:name => 'Earl')
    steve = Person.create(:name => 'Steve')
    stacey = Person.create(:name => 'Stacey', :parent_id_1  => earl.id, :parent_id_2 => steve.id)
    stacey.find_parents.should eq ['Earl', 'Steve']
  end

end
