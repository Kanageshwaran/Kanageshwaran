# Define a struct-like class
class ElapsedTime:
    def __init__(self):
        self.weeksVal = 0
        self.daysVal = 0


def ConvertToWeeksAndDays(totalDays):
    # Create an ElapsedTime object
    tempVal = ElapsedTime()

    # Compute weeks and days
    tempVal.weeksVal = totalDays // 7
    tempVal.daysVal = totalDays % 7

    # Return the struct-like object
    return tempVal


def main():
    totalDays = int(input().strip())

    elapsedDays = ConvertToWeeksAndDays(totalDays)

    # Output in zyBooks format
    print(f"{elapsedDays.weeksVal} weeks {elapsedDays.daysVal} days")


main()
