require "spec_helper"

describe Virtus::Multiparams do
  it "has a version number" do
    expect(Virtus::Multiparams::VERSION).not_to be nil
  end

  class Example
    include Virtus
    include Virtus::Multiparams

    attribute :array, Array
    attribute :date, Date
    attribute :time, Time
    attribute :datetime, DateTime
  end

  it "correctly coerces arrays" do
    expect(Example.new(
      "array(1)" => "a",
      "array(2)" => "b",
      "array(3)" => "c",
    ).array).to eq(["a", "b", "c"])
  end

  it "correctly coerces sparse arrays" do
    expect(Example.new(
      "array(3)" => "c",
      "array(5)" => "e",
    ).array).to eq([nil, nil, "c", nil, "e"])
  end

  it "correctly coerces integers" do
    expect(Example.new(
      "array(1i)" => "1",
    ).array).to eq([1])
  end

  it "correctly coerces floats" do
    expect(Example.new(
      "array(1f)" => "1.5",
    ).array).to eq([1.5])
  end

  it "correctly coerces Dates" do
    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "5",
      "date(3i)" => "7",
    ).date).to eq(Date.new(2015, 5, 7))
  end

  it "ignores Dates with missing attributes" do
    expect(Example.new(
      # "date(1i)" => "2015",
      "date(2i)" => "5",
      "date(3i)" => "7",
    ).date).to be_nil

    expect(Example.new(
      "date(1i)" => "2015",
      # "date(2i)" => "5",
      "date(3i)" => "7",
    ).date).to be_nil

    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "5",
      # "date(3i)" => "7",
    ).date).to be_nil
  end

  it "ignores Dates with zero attributes" do
    expect(Example.new(
      "date(1i)" => "0",
      "date(2i)" => "5",
      "date(3i)" => "7",
    ).date).to be_nil

    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "0",
      "date(3i)" => "7",
    ).date).to be_nil

    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "5",
      "date(3i)" => "0",
    ).date).to be_nil
  end

  it "ignores Dates with empty attributes" do
    expect(Example.new(
      "date(1i)" => "",
      "date(2i)" => "5",
      "date(3i)" => "7",
    ).date).to be_nil

    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "",
      "date(3i)" => "7",
    ).date).to be_nil

    expect(Example.new(
      "date(1i)" => "2015",
      "date(2i)" => "5",
      "date(3i)" => "",
    ).date).to be_nil
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

  it "ignores DateTimes with missing date attributes" do
    expect(Example.new(
      # "datetime(1i)" => "2015",
      "datetime(2i)" => "5",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil

    expect(Example.new(
      "datetime(1i)" => "2015",
      # "datetime(2i)" => "5",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil

    expect(Example.new(
      "datetime(1i)" => "2015",
      "datetime(2i)" => "5",
      # "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil
  end

  it "ignores DateTimes with empty date attributes" do
    expect(Example.new(
      "datetime(1i)" => "",
      "datetime(2i)" => "5",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil

    expect(Example.new(
      "datetime(1i)" => "2015",
      "datetime(2i)" => "",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil

    expect(Example.new(
      "datetime(1i)" => "2015",
      "datetime(2i)" => "5",
      "datetime(3i)" => "",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil
  end

  it "ignores DateTimes with zero date attributes" do
    expect(Example.new(
      "datetime(1i)" => "0",
      "datetime(2i)" => "5",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil

    expect(Example.new(
      "datetime(1i)" => "2015",
      "datetime(2i)" => "0",
      "datetime(3i)" => "7",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil

    expect(Example.new(
      "datetime(1i)" => "2015",
      "datetime(2i)" => "5",
      "datetime(3i)" => "0",
      "datetime(4i)" => "14",
      "datetime(5i)" => "32",
      "datetime(6i)" => "47",
    ).datetime).to be_nil
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

  it "ignores Times with missing date attributes" do
    expect(Example.new(
      # "time(1i)" => "2015",
      "time(2i)" => "5",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil

    expect(Example.new(
      "time(1i)" => "2015",
      # "time(2i)" => "5",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil

    expect(Example.new(
      "time(1i)" => "2015",
      "time(2i)" => "5",
      # "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil
  end

  it "ignores Times with empty date attributes" do
    expect(Example.new(
      "time(1i)" => "",
      "time(2i)" => "5",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil

    expect(Example.new(
      "time(1i)" => "2015",
      "time(2i)" => "",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil

    expect(Example.new(
      "time(1i)" => "2015",
      "time(2i)" => "5",
      "time(3i)" => "",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil
  end

  it "ignores Times with zero date attributes" do
    expect(Example.new(
      "time(1i)" => "0",
      "time(2i)" => "5",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil

    expect(Example.new(
      "time(1i)" => "2015",
      "time(2i)" => "0",
      "time(3i)" => "7",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil

    expect(Example.new(
      "time(1i)" => "2015",
      "time(2i)" => "5",
      "time(3i)" => "0",
      "time(4i)" => "14",
      "time(5i)" => "32",
      "time(6i)" => "47",
    ).time).to be_nil
  end
end
