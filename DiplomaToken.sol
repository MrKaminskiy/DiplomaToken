// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";
import "@openzeppelin/contracts@4.7.3/utils/Address.sol";
import "@openzeppelin/contracts@4.7.3/utils/Strings.sol"; 

contract DiplomaToken is ERC721, Ownable {

    // mapping(uint256 => Attr) public attributes;
    string public baseExtension = ".json";

    // struct Attr {
    //     string diplomaID;
    //     string studentName;
    //     int yearFinished;
    //     string eduInstName;

    // }


    // ====== 1. Property Variables ====== //

    using Counters for Counters.Counter;
    //uint256 public MINT_PRICE = 0.0005 ether;
    /// @dev Base token URI used as a prefix by tokenURI().
    string public baseTokenURI;

    Counters.Counter private _tokenIdCounter;

    // ====== 2. Lifecycle Methods ====== //

    constructor() ERC721("DiplomaToken", "DTK") {
        //Start Token IDs at 1. By default it starts at 0.
        _tokenIdCounter.increment();
        baseTokenURI = "";
    }

    
    /// @dev Returns an URI for a given token ID
    function _baseURI() internal view virtual override returns (string memory) {
        return "ipfs://QmYzT4iovKu4KYo5hf1aD5TUWP32P4VR62ePvFKpJfVTPt/";
        //return "https://levelcheck.ru/diplomaID/"
    }

    function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
        baseExtension = _newBaseExtension;
    }

    // @dev Gets URL with metadata information
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0 ? string(abi.encodePacked(currentBaseURI, Strings.toString(tokenId), baseExtension)) : "";
    } 

    // @dev Sets the base token URI prefix.
    // function setBaseTokenURI(string memory _baseTokenURI) public {
    // baseTokenURI = _baseTokenURI;
    // }

    // ====== 3. Minting Functions ====== //

    function mint(
        address to
        // string memory _diplomaID,
        // string memory _studentName,
        // int _yearFinished,
        // string memory _eduInstName
        )
        public payable onlyOwner {
        //require(msg.value > MINT_PRICE, "Not enough ETH sent");
        uint256 tokenId = _tokenIdCounter.current();
        // attributes[tokenId] = Attr(_diplomaID, _studentName, _yearFinished, _eduInstName);
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}

