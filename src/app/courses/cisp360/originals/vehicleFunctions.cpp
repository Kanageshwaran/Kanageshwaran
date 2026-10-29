#include <iostream>
#include <iomanip>
#include <cstring>
#include "vehicle.h"
using namespace std;

bool validateVehicle(vehicleData*newData)
{
    bool result = false;
    int withSpace = 0, withOutSpace = 0;
    int k;
    for( k =0; k < Max_Model;k++)
    {
        if(isalpha(newData->model[k])|| isspace(newData->model[k]) )
            {
                withSpace++;
                if(!isspace(newData->model[k]))
                {
                    withOutSpace++;
                }

            }
    }
    if(withSpace >= 24)
    {
        if(withOutSpace >=15)
        {
            if(newData->cylinders >= 1 && newData->cylinders <= 12)
            {
                if(newData->engine >= 0.1 && newData->engine <= 20.0)
                {
                    if(newData->cost >= 0.0 && newData->cost <= 250000.00)
                    {
                        result = true;
                    }
                }
            }
        }
    }
        return result;
}
void displayVehicle(vehicleData*newData)
{
 for(int i =0;i < Max_Vehicles;i++)
 {
     cout << "Vehicle model:" << newData[i]->model << endl;
     cout << "vehicle manufacturer: "<< newData[i]->manufacturer << endl;
     cout << "# cylinders: " << newData[i]->cylinders << endl;
     cout << "Engine displacement (Liters): "<< newData[i]->engine<<endl;
     cout << "Cost: "<<newData[i]->cost << endl;
 }
}
