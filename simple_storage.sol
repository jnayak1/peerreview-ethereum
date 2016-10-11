contract PeerReview {
  uint public value;
  address public researcher;
  address public journal;
  enum State { Created, Approved, Declined }
  State public state;
  hash fileHash;

  function PeerReview(uint initValue, address initResearcher, address initJournal, hash initFileHash) {
    researcher = initResearcher;
    journal = initJournal;
    value = initValue;
    fileHash = initFileHash;
  }
  
  modifier inState(State _state) {
    if (state != _state) throw;
    _;
  }

  function getResearcher() constant return (address retResearcher) {
    return researcher;
  }

  function getJournal() constant returns (address retJournal) {
    return journal;
  }

  function getState() constant returns (State retState) {
    return state;
  }

  function getValue() constant returns (uint retVal) {
    return value;
  }

  function getFileHash() constant returns (hash retHash) {
    return fileHash;
  }






}
