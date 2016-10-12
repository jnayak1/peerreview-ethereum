contract PeerReview {
  uint public value;
  address public researcher;
  address public journal;
  enum State { Created, Approved, Declined }
  State public state;
  hash fileHash;

  function PeerReview(address initJournal, hash initFileHash)
    payable 
  {
    researcher = msg.sender;
    journal = initJournal;
    value = msg.value;
    state = State.Created;
    fileHash = initFileHash;
  }

  modifier inState(State _state) {
    if (state != _state) throw;
    _;
  }

  modifier onlyJournal() {
    if(msg.sender != journal) throw;
    _;
  }

  event peerReviewApproved();
  event peerReviewDeclined();

  function approve()
    onlyJournal
    inState(Created)
  {
    peerReviewApproved();

    // set state to approved
    state = State.Approved;

    // transfer all ether to journal
    if(!journal.send(this.balance)){
      throw;
    }
  }

  function decline()
    onlyJournal
    inState(Created)
  {
    peerReviewDeclined();

    // set state to declined
    state = State.Declined;

    // transfer all ether back to researcher
    if(!researcher.send(this.balance)){
      throw;
    }
  }
}
