// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearnToEarn {
    address public owner;

    // Struct to represent a user
    struct User {
        uint256 points;
        uint256 lessonsCompleted;
    }

    mapping(address => User) public users;

    // Event to track points earned by a user
    event PointsEarned(address indexed user, uint256 points);

    // Event to track lesson completion
    event LessonCompleted(address indexed user, uint256 lessonId);

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to reward points to a user for completing a lesson
    function completeLesson(uint256 lessonId) external {
        // Each lesson rewards 10 points (can be adjusted)
        uint256 points = 10;

        users[msg.sender].points += points;
        users[msg.sender].lessonsCompleted += 1;

        emit PointsEarned(msg.sender, points);
        emit LessonCompleted(msg.sender, lessonId);
    }

    // Function to get the user's points
    function getUserPoints(address user) external view returns (uint256) {
        return users[user].points;
    }

    // Function to get the number of lessons completed by the user
    function getLessonsCompleted(address user) external view returns (uint256) {
        return users[user].lessonsCompleted;
    }

    // Function to withdraw funds (if any) from the contract
    function withdraw(uint256 amount) external onlyOwner {
        payable(owner).transfer(amount);
    }

    // Fallback function to accept ETH
    receive() external payable {}
}
