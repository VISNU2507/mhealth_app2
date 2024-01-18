import datetime
import random
import numpy as np 
import matplotlib.pyplot as plt

# FakeHeartRateMonitor class
class FakeHeartRateMonitor():
    def __init__(self):
        self.prev_hr = 60
        self.time_now = datetime.datetime.now()

    def get_heart_rate(self):
        change = random.randint(-2, 2)
        if random.random() < 0.1:  
            change += random.randint(-70, 70)

        new_rate = min(max(self.prev_hr + change, 40), 160)
        
        self.time_now = self.time_now + datetime.timedelta(seconds=1)
        return [new_rate, datetime.datetime.timestamp(self.time_now)]
    
# Generate heart rate data
monitor = FakeHeartRateMonitor()
hours = 12
heart_rate_data = np.array([monitor.get_heart_rate() for x in range(hours * 60 * 60)])

# Process for average data
window = 60 # seconds
average_data = []
for i in range(0, len(heart_rate_data) - window, window):
    window_data = heart_rate_data[i : i+window, :]
    avg_hr = np.mean(window_data[:, 0])
    average_data.append([round(avg_hr, 1), window_data[:, 1][0]])

# Preparing data for plot
heart_rate_data = average_data
xaxis = [datetime.datetime.fromtimestamp(x).strftime("%H:%M:%S") for x in np.array(heart_rate_data)[:,1]]
yaxis = np.array(heart_rate_data)[:,0]

# Plotting
plt.figure(figsize=(25, 10))
plt.plot(xaxis, yaxis) 

plt.title('12 Hour Heart Rate Monitoring')
plt.xlabel('Time')
plt.ylabel('Heart Rate (BPM)')
plt.xticks(np.array(xaxis)[:: int(len(xaxis) / 60)])
plt.xticks(rotation=45)
plt.tight_layout()

# Show the plot
plt.show()
