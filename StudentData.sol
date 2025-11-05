// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StudentData {
    struct Student {
        uint id;
        string name;
        uint age;
        string course;
    }

    Student[] public students;
    mapping(uint => uint) private idToIndex;
    address public owner;

    event StudentAdded(uint id, string name);

    constructor() {
        owner = msg.sender;
        addStudent(1, "Mohit", 21, "Computer Engineering");
        addStudent(2, "Anjali", 20, "Mechanical Engineering");
        addStudent(3, "Rohit", 22, "Electrical Engineering");
        addStudent(4, "Priya", 19, "Civil Engineering");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function addStudent(
        uint _id,
        string memory _name,
        uint _age,
        string memory _course
    ) public onlyOwner {
        require(idToIndex[_id] == 0, "Student ID already exists"); // Prevent duplicates
        Student memory newStudent = Student(_id, _name, _age, _course);
        students.push(newStudent);
        idToIndex[_id] = students.length - 1;
        emit StudentAdded(_id, _name);
    }

    function getStudent(uint _id)
        public
        view
        returns (uint, string memory, uint, string memory)
    {
        require(idToIndex[_id] > 0, "Student does not exist");
        Student memory s = students[idToIndex[_id]];
        return (s.id, s.name, s.age, s.course);
    }

    function getTotalStudents() public view returns (uint) {
        return students.length;
    }
}
