class RidesController < ApplicationController

	def index
		#redirect_to 'dispatch#index'
	end

	def new
		@ride = Ride.new
	end

	def destroy
		@ride = Ride.find(params[:id])
		@ride.destroy
		redirect_to dispatch_path
	end

	def create
		@ride = Ride.new(rides_params)
		@ride.save
		redirect_to @ride
	end

	def show
		@ride = Ride.find(params[:id])
	end

	def edit
		@ride = Ride.find(params[:id])
		redirect_to @dispatch
	end

	def update
		@ride = Ride.find(params[:id])
		if @ride.update(rides_params)
		redirect_to @ride
		else
		render 'edit'
		end
	end

	def confirm_pickup
		@ride = Ride.find(params[:ride_id])
		@ride.confirm_pickup!

		@completed_rides = Ride.completed if @ride.confirmed?
	end

	def confirm_dropoff
		@ride = Ride.find(params[:ride_id])
		@ride.confirm_dropoff!

		@completed_rides = Ride.completed if @ride.confirmed?
	end

	private
	def rides_params
		params.require(:ride).permit(:name, :pickup_location_id, :dropoff_location_id, :passenger_count, :comments)
	end
end
