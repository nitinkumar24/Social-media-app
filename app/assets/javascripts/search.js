var ready;
ready = function() {
    var engine = new Bloodhound({
        datumTokenizer: function(d) {
            console.log(d);
            return Bloodhound.tokenizers.whitespace(d.title);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '/search/autocomplete?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    var promise = engine.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

    document.addEventListener("turbolinks:load", function() {
    $('.typeahead').typeahead(null, {
        name: 'engine',
        displayKey: 'name',
        source: engine.ttAdapter()

    });
    });
}

$(document).on('ready', ready);
