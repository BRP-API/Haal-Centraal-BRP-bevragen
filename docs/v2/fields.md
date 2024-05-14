---
layout: page-with-side-nav
title: Haal Centraal BRP Personen Bevragen
---


<style>
  .check-tree li {
    list-style-type: none
  }

  #fields {
    width: 100%;
  }

  .hidden {
    display: none;
  }

  .toggleButton {
    border-radius: 50%;
    font-family: monospace;
    font-weight: 800;
    cursor: pointer;
    padding: 0px 5px;
  }
</style>

# Fields samenstellen
Bij het gebruik van de {{ site.apiname }} moet in de fields parameter worden opgegeven welke gegevens je wilt ontvangen.
Hieronder bieden we een tool om de waarde voor de fields parameter samen te stellen. Hiervoor selecteer je elk veld dat je wilt ontvangen.

Meer details over hoe fields werkt lees je in het [feature overzicht](./features-overzicht#filteren-van-de-velden-van-de-gevonden-personen){:target="_blank" rel="noopener"}

Sommige gegevens krijg je [automatisch geleverd](./features-overzicht#standaard-geleverde-velden), dus die hoef en mag je niet vragen.

Velden onder [verblijfplaatsBinnenland](./features-overzicht#filteren-van-verblijfplaats-velden){:target="_blank" rel="noopener"} en [adresseringBinnenland](./features-overzicht#filteren-van-adresregels-velden){:target="_blank" rel="noopener"} gebruik je wanneer je wel het adres wilt opvragen, maar niet geautoriseerd bent voor buitenlandse adressen.

## 1. selecteer het zoektype
Met fields mag je alleen vragen om gegevens die bij het vraagtype teruggegeven kunnen worden. Daarom selecteer je eerst het type vraag dat je wilt doen.

<select id="searchType" class="form-control" onchange="loadFieldsList()">
  <option value="Persoon">RaadpleegMetBurgerservicenummer</option>
  <option value="PersoonBeperkt">ZoekMet...</option>
  <option value="GezagPersoonBeperkt">ZoekMetAdresseerbaarObjectIdentificatie</option>
</select>

## 2. selecteer de velden die je wilt ontvangen

<div id="selectors"></div>

## 3. kopieer de waarde hieronder en gebruik dit in je request bij de fields parameter

<textarea id="fields" class="form-control"></textarea>

<script>
  loadFieldsList();


  function loadFieldsList() {
    // haal de lijst met toegestane velden op voor het geselecteerde type
  
    document.getElementById("fields").value = "";

    var responseObjectName = document.getElementById("searchType").value;

    var ajaxRequest = new XMLHttpRequest();
    ajaxRequest.onreadystatechange = function(){
      if(ajaxRequest.readyState == 4){
        if(ajaxRequest.status == 200){
          renderFieldSelectors(responseObjectName, ajaxRequest.responseText.split(/\r?\n/))
        } else {
          document.getElementById("selectors").innerHTML = "Status error: " + ajaxRequest.status;
        }
      }
    }

    ajaxRequest.open("GET", "https://raw.githubusercontent.com/BRP-API/Haal-Centraal-BRP-bevragen/master/features/fields-filtered-" + responseObjectName + ".csv", true);
    ajaxRequest.send();
  }

  function renderFieldSelectors(responseObjectName, fieldsList) {
    // maak de lijst met velden inclusief checkboxes
  
    fieldsList.shift(); // kolomkop overslaan

    var selectors = document.getElementById("selectors");
    selectors.innerHTML = '<ul id="fields-tree" class="check-tree"></ul>';
    addTreeItem(fieldsList);
    hideUselessToggleButtons();
  }

  function addTreeItem(fieldsList) {
    // voeg volgende veld toe als checkbox
  
    if (fieldsList.length == 0) { return; }

    var field = fieldsList.shift();
    if (field=="") { addTreeItem(fieldsList); return; }

    var parent = document.getElementById("fields-tree");
    if (field.split('.').length > 1) { parent = document.getElementById(field.split('.').slice(0, -1).join('.') + '-list'); }

    li = document.createElement('li');
    li.innerHTML = `<input type="checkbox" id="${field}" class="form-check-input" onchange="click_item(this)"/> `;
    li.innerHTML += field.split('.').slice(-1);
    li.innerHTML += ` <button id="${field}-toggle" onclick="toggleGroupFields('${field}')" class="btn btn-light toggleButton">+</button>`;
    li.innerHTML += `<ul id="${field}-list" class="hidden"></ul>`;
    parent.appendChild(li);

    addTreeItem(fieldsList);
  }

  function hideUselessToggleButtons() {
    // verberg toggle knopjes (+/- voor het openen van een groep) voor alle velden die geen groep zijn
  
    for (element of document.getElementById("fields-tree").getElementsByTagName("li")) {
      var id = element.getElementsByTagName("input")[0].id;
      if (document.getElementById(id + '-list').children.length == 0) {
        document.getElementById(id + '-toggle').classList.add("hidden");
      }
    }
  }

  function click_item(item) {
    // verwerk wijziging in checkbox status op een veld
  
    setChildren(item); // wanneer het gewijzigde veld een groep is, nemen alle velden in de groep de status van de groep over
    setParent(item); // wanneer het gewijzigde veld in een groep zit, moet de status van het groepsveld worden bijgewerkt
    setFields(); // stel de fields parameter samen op basis van de geselecteerde velden
  }

  function setChildren(item) {
    // wanneer het veld een groep is, nemen alle velden in de groep de status van de groep over
  
    if (document.getElementById(item.id + "-list").children.length > 0)
    {
      for (child of document.getElementById(item.id + "-list").children) {
        child.getElementsByTagName("input")[0].checked = item.checked;
        child.getElementsByTagName("input")[0].indeterminate = false;
        setChildren(child.getElementsByTagName("input")[0])
      }
    }
  }

  function setParent(item) {
    // wanneer het veld in een groep zit, moet de status van het groepsveld worden bijgewerkt
  
    if (item.id.split('.').length < 2) { return; } // veld zit niet in een groep

    parentId = item.id.split('.').slice(0, -1).join('.');
    parent = document.getElementById(parentId);

    determineCheckStatus(parent);

    setParent(parent);
  }

  function determineCheckStatus(item) {
    //bepaal de status van een groepsveld (item) op basis van de status van de velden in de groep
                                      
    var checked = 0;
    var notChecked = 0;

    for (child of document.getElementById(item.id + "-list").children) {
      if (child.getElementsByTagName("input")[0].checked == true) { 
        checked += 1; 
      } else if ( child.getElementsByTagName("input")[0].indeterminate == true) {
        checked += 1;
        notChecked += 1;
      } else {
        notChecked += 1;
      }
    }

    if (checked > 0 && notChecked == 0) {
      // alle velden van de groep zijn aangevinkt, dus de hele groep wordt gevraagd
      item.checked = true;
      item.indeterminate = false;
      return;
    }
    if (checked > 0 && notChecked > 0) {
      // enkele, maar niet alle velden van de groep zijn gevraagd
      item.checked = false;
      item.indeterminate = true;
      return;
    }

    // checked == 0: geen enkel veld in de groep is aangevinkt
    item.checked = false;
    item.indeterminate = false;
  }

  function setFields() {
    // stel de fields parameter samen op basis van de geselecteerde velden
  
    fields = [];

    elements = document.getElementById("fields-tree").getElementsByTagName("input");
    for (element of elements) {
      if (element.id.split('.').length > 1) {
        parentId = element.id.split('.').slice(0, -1).join('.');
        if (document.getElementById(parentId).checked == true) { continue; }
      }

      if (element.checked == true) { fields.push(element.id); }
    };

    document.getElementById("fields").value = JSON.stringify(fields);
  }

  function toggleGroupFields(group) {
    // toon of verberg de velden binnen de groep
  
    var list = document.getElementById(group + '-list');
    var toggleButton = document.getElementById(group + '-toggle');
    if (list.classList.contains('hidden')) {
      list.classList.remove('hidden');
      toggleButton.innerHTML = '-';
    } else {
      list.classList.add('hidden');
      toggleButton.innerHTML = '+';
    }
  }
</script>

