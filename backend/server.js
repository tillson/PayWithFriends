const express = require('express');;
const app = express();

const vision = require('@google-cloud/vision');
const client = new vision.ImageAnnotatorClient();
const crypto = require('crypto');

var activeReceipt = []

var activeUsers = [];

app.post('/api/generateCode', function(req, res) {

});

app.post('/api/uploadReceipt', function(req, res) {
    client
    .textDetection('./testassets/finedining.jpg')
    .then(results => {
        const detections = results[0].textAnnotations;
        var words = []
        for (var i = 0; i < detections.length; i++) {
            var detection = detections[i];
            var poly = detection.boundingPoly.vertices;
            words.push({
                word: detection.description,
                center: { x: (poly[0].x + poly[1].x + poly[2].x + poly[3].x) / 4, y: (poly[0].y + poly[1].y + poly[2].y + poly[3].y) / 4 },
                polygon: poly
            })
        }

        var items = []
        var lines = []
        var currentLine = []
        for (var i = 0; i < words.length; i++) {
            if (currentLine.length == 0 || Math.abs(currentLine[currentLine.length - 1].center.y - words[i].center.y) < 10) {
                currentLine.push(words[i]);
            } else {
                lines.push(currentLine);
                currentLine = [words[i]];
            }
        }
        var firstItemLine = -1;
        var firstPriceLine = -1;
        var strings = [];
        var offset = 0;
        for (var i = 0; i < lines.length; i++) {
            str = '';
            for (var j = 0; j < lines[i].length; j++) {
                str += lines[i][j].word + ' ';
            }
            str = str.trim();
            strings.push(str);
            if (firstItemLine == -1 && str.split(' ')[0].length == 1 && parseInt(str.split(' ')[0]) > -1) {
                if (str.indexOf('Chk') > -1 || str.indexOf('Jan') > -1) {
                    continue;
                }
                firstItemLine = i;
            }
            if (firstItemLine != -1 && firstPriceLine == -1 && str.split(' ').length == 1 && parseFloat(str.split(' ')[0]) > 0) {
                firstPriceLine = i
            }
            if (firstPriceLine != -1 && parseFloat(str.split(' ')[0]) != NaN && offset < firstPriceLine - firstItemLine) {
                var name = strings[firstItemLine + (i - firstPriceLine)].pop();
                var quantity = strings[firstItemLine + (i - firstPriceLine)][0];
                quantity = parseInt(quantity) > -1 ? parseInt(quantity) : 1;
                while (quantity > 0) {
                    var itemData = { id: crypto.createHash('sha1').digest('hex'), name: name, price: parseFloat(str), people: [] };
                    items.push(itemData);
                    quantity--;
                }
                offset++;
            }
        }
        activeReceipt = items;
        return res.json(items);
    })
    .catch(err => {
        console.error('ERROR:', err);
        return res.json([]);
    });

});


app.get('/api/getReceiptItems', function(req, res) {
    return releaseEvents.json(activeReceipt);
});

app.post('/api/updateReceiptItem', function(req, res) {
    if (!req.body.id || !req.body.user) { return res.json({}) };
    for (var i = 0; i < activeReceipt.length; i++) {
        var item = activeReceipt[i];
        if (item.id == req.body.id) {
            if (item.people.indexOf(req.body.user)) {
                item.people.remove(req.body.user);
            } else {
                item.people.push(req.body.user);
            }
            return res.json(item);
        }
    }
});


app.get('/api/reset', function(req, res) {
    activeReceipt = [];
    activeUsers = {};
});

app.listen((process.env.PORT || 8080), function() {
    console.log('Now listening on port ' + (process.env.PORT || 8080) + '!');
})