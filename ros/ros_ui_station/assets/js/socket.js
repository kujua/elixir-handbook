import {Socket} from "phoenix"

let socket = new Socket(WSURL, {params: {token: window.userToken}});

socket.connect();

let channel = socket.channel("rosdata:read", {});
let data = [];

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

channel.on("updated_data", payload => {
    channel.push("get_data_station", {body: window.for_worker, orderid: payload.body})
});

channel.on("receive_data", payload => {
    if (payload.body === "null") {
        console.log("payload.body null")
    } else {
        var j = JSON.parse(payload.body);
        var t = $('#table');
        console.log(j);
        t.bootstrapTable('remove', {field: 'order_id',values: j.order_id});
        t.bootstrapTable('append',JSON.parse(payload.body))
    }
});


window.channel = channel;

export default socket
