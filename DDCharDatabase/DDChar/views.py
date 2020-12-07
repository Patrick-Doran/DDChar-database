from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import * #VSCode hates this, I don't know why, it just does
from django.db import connection

# Create your views here.
def index(request):
    print("Rendered index")
    all_members = User.objects.raw('''
        SELECT *
        FROM user
    ''')
    return render(request, "DDChar/index.html", {'all':all_members}) #Pass all to html via dictionary

def spells(request):
    print("Rendered spells")
    all_spells = Spell.objects.raw('''
        SELECT *
        FROM spell
        GROUP BY sp_name
    ''')
    return render(request, "DDChar/spells.html", {'allSpell':all_spells})

