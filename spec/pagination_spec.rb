require 'spec_helper'

describe Mongoid::Pagination do
  class Person
    include Mongoid::Document
    include Mongoid::Pagination
  end

  describe ".paginate" do
    let!(:one)   { Person.create! }
    let!(:two)   { Person.create! }
    let!(:three) { Person.create! }
    let!(:four)  { Person.create! }

    context "parameter defaults and massaging" do
      describe "when no params are passed in" do
        subject { Person.paginate }

        it "does not set the skip param by default" do
          subject.options[:skip].should be_nil
        end

        it "defaults the limit param to 25" do
          subject.options[:limit].should be_nil
        end

        it "returns the criteria unmodified if the limit param is not passed in" do
          criteria = Person.where(:name => 'someone')
          expect {
            criteria.paginate
          }.not_to change { criteria.options }
        end
      end

      describe "when passed a page param but no limit" do
        subject { Person.paginate(:page => 1) }

        it "defaults the limit to 25" do
          subject.options[:limit].should == 25
        end

        it "sets the offset to 0" do
          subject.options[:skip].should == 0
        end
      end

      describe "when passed a limit param but no page" do
        subject { Person.paginate(:limit => 100) }

        it "defaults the page to 0" do
          subject.options[:skip].should == 0
        end

        it "sets the limit to 100" do
          subject.options[:limit].should == 100
        end
      end

      it "sets the skip param to 0 if passed 0" do
        Person.paginate(:page => 0).options[:skip].should == 0
      end

      it "sets the skip param to 0 if passed a string of 0" do
        Person.paginate(:page => '0').options[:skip].should == 0
      end

      it "sets the skip param to 0 if the passed a string of 1" do
        Person.paginate(:page => '1').options[:skip].should == 0
      end

      it "limits when passed a string param" do
        Person.paginate(:limit => '1').to_a.size.should == 1
      end

      it "correctly sets criteria options" do
        Person.paginate(:limit => 10, :page => 3).options.should == {:limit => 10, :skip => 20}
      end
    end

    context "results" do
      it "paginates correctly on the first page" do
        Person.paginate(:page => 1, :limit => 2).to_a.should == [one, two]
      end

      it "paginates correctly on the second page" do
        Person.paginate(:page => 2, :limit => 2).to_a.should == [three, four]
      end
    end

    it "paginates the result set based on the limit and page params" do
      # Person.
    end
  end

  describe ".per_page" do
    before do
      2.times { Person.create! }
    end

    it "limits the results by the per page param" do
      Person.per_page(1).to_a.size.should == 1
    end

    it "works for string params" do
      Person.per_page('1').to_a.size.should == 1
    end

    it "defaults to 25" do
      Person.per_page.options[:limit].should == 25
    end
  end
end
