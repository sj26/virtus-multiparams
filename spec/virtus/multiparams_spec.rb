require "spec_helper"

describe Virtus::Multiparams do
  it "has a version number" do
    expect(Virtus::Multiparams::VERSION).not_to be nil
  end

  class Example
    include Virtus
    include Virtus::Multiparams

    attribute :date, Date
    attribute :time, Time
    attribute :datetime, DateTime
  end

  it "correctly coerces Dates" do
    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "5",
      "date(3i)" => "7",
    ).date).to eq(Date.new(2015, 5, 7))
  end

  it "correctly coerces DateTimes" do
    expect(Example.new(
      "datetime(1i)" => "2015",
      "datetime(2i)" => "5",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to eq(Time.new(2015, 5, 7, 14, 32, 47).to_datetime)
  end

  it "correctly coerces Times" do
    expect(Example.new(
      "time(1i)" => "2015",
      "time(2i)" => "5",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to eq(Time.new(2015, 5, 7, 14, 32, 47))
  end
end
