require_relative 'spec_helper'
require_relative '../lib/trip'
require_relative '../lib/driver'
require_relative '../lib/rider'

describe "Trip class" do

  it "is an instance of Trip" do
    test_trip = RideShare::Trip.new({id: 1, rider_id: 33, driver_id: 22, date: "01-02-0102", rating: 5})
    test_trip.must_be_kind_of RideShare::Trip
  end

  describe "get_driver method" do
    before do
      @trip = RideShare::Trip.new({id: 8, driver_id: 93, rider_id: 104, date: "2016-08-08", rating: 5})
    end
    it "returns an instance of Driver" do
      @trip.get_driver.must_be_kind_of RideShare::Driver
    end
    it "Driver's id matches driver_id on instance of Trip" do
      @trip.get_driver.id.must_equal 93
    end
  end

  describe "get_rider method" do
    before do
      @trip = RideShare::Trip.new({id: 8, driver_id: 93, rider_id: 104, date: "2016-08-08", rating: 5})
    end
    it "returns an instance of Rider" do
      @trip.get_rider.must_be_kind_of RideShare::Rider
    end
    it "Rider's id matches rider_id on instance of Trip" do
      @trip.get_rider.id.must_equal 104
    end
  end

  describe "self.all_for_driver(id) method" do

    it "returns array" do
      RideShare::Trip.all_for_driver(2).must_be_kind_of Array
    end
    it "all items in array must be Trips" do
      trips = RideShare::Trip.all_for_driver(2)
      trips.each do |trip|
        trip.must_be_kind_of RideShare::Trip
      end
    end
    it "all driver_ids of Trips in array must match the id passed in" do
      trips = RideShare::Trip.all_for_driver(2)
      trips.each do |trip|
        trip.driver_id.must_equal 2
      end
    end
  end

  describe "self.all_for_rider(id) method" do
    it "returns array" do
      RideShare::Trip.all_for_rider(2).must_be_kind_of Array
    end
    it "all items in array must be Trips" do
      trips = RideShare::Trip.all_for_rider(2)
      trips.each do |trip|
        trip.must_be_kind_of RideShare::Trip
      end
    end
    it "all rider_ids of Trips in array must match the id passed in" do
      trips = RideShare::Trip.all_for_rider(2)
      trips.each do |trip|
        trip.rider_id.must_equal 2
      end
    end
  end

  describe "self.all method" do
    let(:all_trips) {RideShare::Trip.all}
    let(:trip_test) {nil}
    it "returns an array" do
      all_trips.must_be_kind_of Array
    end
    it "all elements are Trip instances" do
      all_trips.each do |trip|
        trip.must_be_kind_of RideShare::Trip
      end
    end
    it "grabs first line of data from csv" do
      # test_trip = nil
      trip_test = all_trips.find {|trip| trip.id == 1}
      trip_test.must_be_kind_of RideShare::Trip
    end
    it "grabs last line of data from csv" do
      # test_trip = nil
      trip_test = all_trips.find {|trip| trip.id == 600}
      trip_test.driver_id.must_equal 61
    end
    it "grabs random middle line of data from csv" do
      # test_trip = nil
      trip_test = all_trips.find {|trip| trip.id == 230}
      trip_test.date.must_equal "2016-10-12"
    end
  end

end
