// classroom student size

const api = module.exports;
const fs = require('fs');
const path = require('path');

require('dotenv').config();

const classDataPath = path.resolve(__dirname, '../../class_data.json');
const class_data = JSON.parse(fs.readFileSync(classDataPath, 'utf8'));

api.getSchedules = (req, res) => {
    const { roomNumber } = req.query;
    if (!roomNumber) {
        return class_data;
    } else {
        const events = getEvents(roomNumber);

        const classRoom = class_data.find(room => parseInt(room.roomNumber) === parseInt(roomNumber));
        if (!classRoom) {
            res.status(404).send('Room not found');
        }
        const filtered = filterSchedule(classRoom, events);
        res.json(filtered);
    }
};

api.addEvent = (req, res) => {
    checkAdmin(req, res);
    const { startTime, endTime, reason, roomNumber } = req.body;
    const newEvent = {
        startTime,
        endTime,
        reason,
        roomNumber,
    };
    // Create a new file for events
    const eventPath = path.resolve(__dirname, '../../events.json');
    let events = [];
    if (fs.existsSync(eventPath)) {
        events = JSON.parse(fs.readFileSync(eventPath, 'utf8'));
    }
    events.push(newEvent);
    fs.writeFileSync(eventPath, JSON.stringify(events, null, 2));
    res.json(newEvent);
};

const checkAdmin = (req, res) => {
    const token = req.headers['x-access-token'];
    if (!token) {
        res.status(401).send({ auth: false, message: 'No token provided.' });
    }
    if (token !== process.env.ADMIN_TOKEN) {
        res.status(401).send({ auth: false, message: 'Failed to authenticate token.' });
    }
};

const getEvents = (roomNumber) => {
    const eventPath = path.resolve(__dirname, '../../events.json');
    let events = [];
    if (fs.existsSync(eventPath)) {
        events = JSON.parse(fs.readFileSync(eventPath, 'utf8'));
    }

    return events.filter(event => event.roomNumber === parseInt(roomNumber));
};

/**
 * @function filterSchedule
 * @description Filter out events from a class room's schedule
 * @param {*} classRoom 
 * @param {*} events 
 * @returns {*} A new class room object with the events filtered out
 */
const filterSchedule = (classRoom, events) => {
    console.log(`Filtering schedule for room ${classRoom.roomNumber}`);
    console.log(`Events: ${JSON.stringify(events)}`);
    // Create a Set for faster lookups
    const eventSet = new Set(events.map(event => 
        `${event.roomNumber}-${event.startTime}-${event.endTime}`
    ));

    console.log(`Event Set: ${JSON.stringify([...eventSet])}`);

    const filteredSchedule = classRoom.schedule.map(day => {
        // Check if `times` exists and is an array
        if (!Array.isArray(day.times)) {
            console.error(`Invalid times for day in room ${classRoom.roomNumber}:`, day.times);
            return day; // Return the day unchanged
        }

        const filteredTimes = day.times.filter(time => {
            const eventKey = `${classRoom.roomNumber}-${time.startTime}-${time.endTime}`;
            console.log(`Checking for event: ${eventKey}`);
            // Exclude the time slot if it's in the eventSet
            if (eventSet.has(eventKey)) {
                console.log(`Time slot removed: ${eventKey}`);
                return false;
            }
            return true;
        });

        return {
            ...day,
            times: filteredTimes
        };
    });

    return {
        ...classRoom,
        schedule: filteredSchedule
    };
};