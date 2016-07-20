# API

## Get list of facilities

```
GET /catalog
```

**Response**

```
Status: 200 OK
```
----
```
{
    "data": {
        "header": [
            {
                "key": "@ref",
                "name": "ref",
                "desc": "The reference of the facility"
            },
            {
                "key": "name",
                "name": "Name",
                "desc": "The name of the facility"
            },
            {
                "key": "desc",
                "name": "Description",
                "desc": "The description of the facility"
            },
        ],
        "payload": [
            {
                "@ref": "http://localhost:8888/catalog/SNS",
                "name": "SNS",
                "desc": "Spallation Neutron Source",
            },
            {
                "@id": "http://localhost:8888/catalog/HFIR",
                "name": "HFIR",
                "desc": "High Flux Isotope Reactor"
            }
        ],
    },
    "error": null,
    "message": "",
}
```

## Get list of instruments at facility

```
GET /catalog/:facility
```

**Response**

```
Status: 200 OK
```
----
```
{
    "data": {
        "header": [
            {
                "key": "@ref",
                "name": "ref",
                "desc": "The reference of the instrument"
            },
            {
                "key": "name",
                "name": "Name",
                "desc": "The name of the instrument"
            },
            {
                "key": "desc",
                "name": "Description",
                "desc": "The description of the instrument"
            },
        ],
        "payload": [
            {
                "@id": "SNS",
                "name": "SNS",
                "desc": "Spallation Neutron Source",
            },
            {
                "@id": "HFIR",
                "name": "HFIR",
                "desc": "High Flux Isotope Reactor"
            }
        ],
    },
    "error": null,
    "message": "",
}
```

## Get list of experiments for instrument

```
GET /catalog/:facility/:instrument
```
