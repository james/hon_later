require File.dirname(__FILE__) + "/spec_helper"

describe Link do
  before(:each) do
    Link.delete_all
    ENV['PAPERLATER_KEY'] = 'test_key'
    stub_request(:get, "https://paperlater.com/save?token=test_key&url=http://abscond.org")
  end

  describe "unprinted" do
    before(:each) do
      @posted_link = Link.create(:sent_to_print_at => Time.now, :url => 'http://abscond.org')
      @unposted_link = Link.create(:sent_to_print_at => nil, :url => 'http://abscond.org')
    end
    it "should return unprinted links" do
      expect(Link.unprinted).to eq([@unposted_link])
    end
  end

  describe "print_unprinted" do
    before(:each) do
      @unposted_link = Link.create(:sent_to_print_at => nil, :url => 'http://abscond.org')
      Link.stub(:unprinted).and_return([@unposted_link])
    end
    it "should submit those unsubmitted" do
      expect(@unposted_link).to receive(:submit_to_paperlater!)
      Link.print_unprinted!
    end
  end

  describe "submit_to_paperlater" do
    before(:each) do
      @link = Link.create(:url => 'http://abscond.org')
    end

    it "should submit url to paperlater" do
      @link.submit_to_paperlater!
      WebMock.should have_requested(:get, "https://paperlater.com/save?token=test_key&url=http://abscond.org")
    end

    it "should update sent at" do
      @time = Time.now
      Time.stub(:now).and_return(@time)
      @link.submit_to_paperlater!
      @link.sent_to_print_at.should == @time
    end
  end
end