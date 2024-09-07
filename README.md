# Attendeease - Geofencing-Based Attendance System 
Attendeease is a mobile application designed to streamline and automate attendance tracking for employees across multiple office locations. The app leverages geolocation and geofencing technology to accurately log employee check-in and check-out times as they enter and leave office premises. This ensures seamless attendance management, improves operational efficiency, and reduces errors associated with manual tracking.

# Key Features
# Geolocation-Based Check-In/Check-Out:
Employees are automatically checked in when they enter a 200-meter radius around their assigned office and checked out when they leave. This system pairs each check-in with a corresponding check-out, even if the employee enters and exits multiple times throughout the day.

# Manual Check-In/Check-Out for Offsite Work:
Employees working offsite can manually check in and check out from suggested locations based on real-time GPS data. The app provides suggested nearby locations, allowing the employee to confirm their check-in/out manually.

# Working Hours Calculation:
Automatically calculate total working hours by pairing each check-in with the corresponding check-out. The app provides detailed reports of daily, weekly, and monthly work hours.

# Data Accuracy and Integrity:
All check-in/out data is securely stored and synchronized in real time, ensuring reliability and preventing data tampering. Even in low-network conditions, the data remains accurate and up-to-date once a connection is restored.

# Tech Stack
Frontend: Flutter (for cross-platform development)
Backend: Firebase Firestore (for real-time database and secure data storage)
Geolocation Services: Google Maps API and Geolocation Plugins
Authentication: Firebase Authentication (for secure user login)

# How It Works
Employees are automatically checked in when they enter a predefined geofenced area (200 meters around their office).
For offsite work, employees can manually check in and out by selecting their current location.
The app tracks total working hours by pairing check-in and check-out events.
All data is securely stored in Firebase Firestore, with real-time synchronization ensuring accurate records.
