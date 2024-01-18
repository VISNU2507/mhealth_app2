import json
import datetime
import matplotlib.pyplot as plt

# Read JSON data from a file
with open('C:\\Users\\Visnu\\AppData\\Local\\Google\\AndroidStudio2022.3\\device-explorer\\samsung SM-G950F\\data\\data\\com.example.mhealth_app1\\app_flutter\\WALK1705576624030.json', 'r') as file:
    # rest of your code

    data = json.load(file)

# Extract heart rate and timestamps
heart_rate_data = data['stores'][0]['values']
timestamps = [entry['timestamp'] for entry in heart_rate_data]
heart_rates = [entry['hr'] for entry in heart_rate_data]

# Convert timestamp to readable format
xaxis = [datetime.datetime.fromtimestamp(ts / 1000).strftime("%H:%M:%S") for ts in timestamps]

# Plotting
plt.figure(figsize=(25, 10))
plt.plot(heart_rates)

plt.title('Heart Rate Monitoring: Walk')
plt.xlabel('Time')
plt.ylabel('Heart Rate (BPM)')
plt.xticks(rotation=45)
plt.tight_layout()

plt.show()
