-- Amount in % 

TrafficAmount = 5
PedestrianAmount = 10
ParkedAmount = 25
ParkedNumber = 25 -- Este valor es un valor numerico, no %
EnableDispatch = false
GarbageTruck = false
Boats = false 
Train = true
Cops = false

--[[
	TrafficAmount changes how much traffic there is on the Roads, this goes from 100% to 0%, values over 100% are also supported but not recommended, under 0% will cause a game crash.
	PedestrianAmount changes how many Peds roam the Streets
	ParkedAmount changes how many Parked Cars there are in the world
	EnableDispatch is a toggle between true and false, this enables/disables various features such as:
		- Police Responses
		- Fire Department Responses
		- Swat Responses
		- Ambulance Responses
		- Roadblocks
		- Gangs
		


]]