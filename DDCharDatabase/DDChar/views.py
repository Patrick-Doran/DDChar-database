from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import *

# Create your views here.
def index(request):
    print("Rendered index")
    return render(request, "DDChar/index.html")

def spells(request):
    print("Rendered spells")
    return render(request, "DDChar/spells.html")

def getUser(request, userName):
    return HttpResponse("Welcome %s to the database." % userName)

def listUsers(request):
    user_list = User.objects.all()
    if len(user_list) > 1:
        return render(request, 'DDChar/userAll.html', {'user': user_list})
    else:
        return HttpResponse("No users.")

def getCharacter(request, charName, charRace, charLevel):
    response = "Your character stats are as follows: /n Name: %s /n Race: %s /n Level %s"
    return HttpResponse(response % charName, charRace, charLevel)

def createUser(request):
    user = User()
    user.u_name = 'Henry'
    user.u_key = 4
    user.save()
    temp = loader.get_template('DDChar.html')
    context = {
        'new_user':user.pk,
    }
    return HttpResponse(temp.render(context, request))