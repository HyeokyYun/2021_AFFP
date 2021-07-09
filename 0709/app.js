//발신자의 초기 제안으로 새 방을 만들기 위한 코드
const offer = await peerConnection.createOffer();
await peerConnection.setLocalDescription(offer);

const roomWithOffer = {
    offer: {
        type: offer.type,
        sdp: offer.sdp
    }
}
const roomRef = await db.collection('rooms').add(roomWithOffer);
const roomId = roomRef.id;
document.querySelector('#currentRoom').innerText = `Current room is ${roomId} - You are the caller!`
